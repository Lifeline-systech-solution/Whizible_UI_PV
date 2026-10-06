/* Whizible PSA/PPM Dashboard Suite — app.js */
const PORTFOLIOS = [];
const PF_COLOR = {"Banking & FS":"#479EF5","Healthcare":"#54B054","Retail & CPG":"#EAA300","Manufacturing":"#9373C0"};
const FX_RATES = { INR: 1, USD: 83.20, EUR: 90.40, SGD: 61.80 };
const REGION_CURRENCY = { "India": "INR", "US": "USD", "DE": "EUR", "SG": "SGD" };

const PROJECTS = [];

const RESOURCES = [];
const SKILLS = [];

const INVOICES = [];

const REV_TREND  = [];
const COST_TREND = [];
const MONTHS = ["Jul-25","Aug-25","Sep-25","Oct-25","Nov-25","Dec-25","Jan-26","Feb-26","Mar-26","Apr-26","May-26","Jun-26"];

/* Project Hours Report (preview.html) — calendar-year 2026 target vs actual */
const HR_MONTHS = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
const HOUR_PROJECTS = [];
const hoursState = {from:0,to:11,project:"all",metric:"hours",view:"line",sort:"actual",dir:-1,exception:null,hideZero:true,filterSearch:"",tableSearch:"",axisMode:"auto",rangeChip:"year"};

/* =====================================================================
   MULTI-PAGE SUPPORT
   Each dashboard page (exec.html, projects.html, resources.html, ...) loads
   this SAME app.js + styles.css. The only thing that differs per page is
   which single <section id="page-XXX"> exists in that page's HTML, plus a
   data-page attribute on <body>. Everything else (data model, filters,
   charts, drilldown, copilot, scenario planner) is fully shared/unchanged.
===================================================================== */
const CURRENT_PAGE = document.body.dataset.page || "exec";
const LS_KEY = "whizible_state_v1";
function persistState(){ // save cross-page context (filters/date/theme/role) so it survives real page navigation
  try{
    localStorage.setItem(LS_KEY, JSON.stringify({
      filters: state.filters,
      date: {
        label:state.date.label,
        range:state.date.range,
        months:state.date.months,
        compare:state.date.compare,
        compareMode:state.date.compareMode||"prev_dow",
        comparisonName:state.date.comparisonName||"",
        comparisonId:state.date.comparisonId||null,
        filterId:state.date.filterId||null,
        s: state.date.s ? new Date(state.date.s).toISOString() : null,
        e: state.date.e ? new Date(state.date.e).toISOString() : null,
        cs: state.date.cs ? new Date(state.date.cs).toISOString() : null,
        ce: state.date.ce ? new Date(state.date.ce).toISOString() : null
      },
      theme: document.documentElement.dataset.theme,
      role: document.getElementById("roleSel") ? document.getElementById("roleSel").value : undefined
    }));
  }catch(e){}
}
function restoreState(){ // re-hydrate on each page load
  try{
    const raw = localStorage.getItem(LS_KEY);
    if(!raw) return;
    const saved = JSON.parse(raw);
    if(saved.filters){
      if(Array.isArray(saved.filters.Region) && (!saved.filters["Organization Unit"] || !saved.filters["Organization Unit"].length)){
        saved.filters["Organization Unit"]=saved.filters.Region;
      }
      delete saved.filters.Region;
      Object.assign(state.filters, saved.filters);
      delete state.filters.Region;
    }
    if(saved.date){
      Object.assign(state.date, saved.date);
      if(saved.date.s) state.date.s = new Date(saved.date.s);
      if(saved.date.e) state.date.e = new Date(saved.date.e);
      if(saved.date.cs) state.date.cs = new Date(saved.date.cs);
      if(saved.date.ce) state.date.ce = new Date(saved.date.ce);
    }
    //  Modify By Madhuri.K on 01-10-2026 
    /* Compare stays off until user enables it (same as CXO date picker). */
    state.date.compare=false;
    state.date.comparisonName="";
    state.date.comparisonId=null;
    if(saved.theme) document.documentElement.dataset.theme = saved.theme;
    if(saved.role){
      const sel = document.getElementById("roleSel");
      if(sel){ sel.value = saved.role; }
      if(typeof syncRolePill==="function") syncRolePill();
    }
  }catch(e){}
}

/* =====================================================================
   STATE, FORMATTERS, FILTER ENGINE
===================================================================== */
const state = {
  page:CURRENT_PAGE, theme:"dark",
  date:{label:"Current Quarter",range:"",months:3,compare:false,compareMode:"prev_dow",s:null,e:null,cs:null,ce:null},
  filters:{Portfolio:[],Customer:[],"Project Manager":[],Health:[],"Organization Unit":[],Region:[],"Billing Type":[]},
  trail:[], charts:{}, lastDrillRows:null
};
const $ = s=>document.querySelector(s);
const $$ = s=>[...document.querySelectorAll(s)];
const cr = v => v>=100 ? "₹"+(v/100).toFixed(1)+" Cr" : "₹"+Math.round(v)+" L";
const pct = v => v.toFixed(1)+"%";
const esc = s=>String(s).replace(/[&<>"]/g,c=>({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;"}[c]));

const FILTER_DEFS = {
  Portfolio: PORTFOLIOS,
  Customer: [...new Set(PROJECTS.map(p=>p.customer))],
  "Project Manager": [],
  Health: ["Green","Amber","Red"],
  "Organization Unit": [],
  "Billing Type": []
};
const FIELD = {Portfolio:"portfolio",Customer:"customer","Project Manager":"pm",Health:"health","Organization Unit":p=>p.region.split(" · ")[0],Region:p=>p.region.split(" · ")[0],"Billing Type":"billing"};

function fp(){ // filtered projects
  return PROJECTS.filter(p=>Object.entries(state.filters).every(([k,vals])=>{
    if(!vals.length) return true;
    const f = FIELD[k]; const v = typeof f==="function"?f(p):p[f];
    return vals.includes(v);
  }));
}
function scaleF(){ // revenue scale vs quarter baseline, interpolated for any custom range
  const m=state.date.months,pts=[[0.033,0.011],[0.25,0.083],[1,0.34],[3,1],[6,1.94],[12,3.72]];
  if(m<=pts[0][0])return pts[0][1];
  for(let i=1;i<pts.length;i++){const [a,b]=pts[i-1],[c,d]=pts[i];if(m<=c)return b+(d-b)*(m-a)/(c-a);}
  return 3.72*m/12;
}
function agg(){
  const P=fp(), s=scaleF();
  const rev=P.reduce((a,p)=>a+p.revenue,0)*s, cost=P.reduce((a,p)=>a+p.cost,0)*s;
  const budget=P.reduce((a,p)=>a+p.budget,0), spent=P.reduce((a,p)=>a+p.spent,0);
  const util=P.length?P.reduce((a,p)=>a+p.util,0)/P.length:0;
  const gp=rev-cost, margin=rev?gp/rev*100:0;
  return {P,rev,cost,gp,margin,ebit:gp*0.62,np:gp*0.47,budget,spent,util,
    bench:RESOURCES.filter(r=>r[4]==="BENCH").length,
    active:P.filter(p=>p.status==="In Progress").length,
    delayed:P.filter(p=>p.delayDays>7).length,
    csat:P.length?P.reduce((a,p)=>a+p.csat,0)/P.length:0,
    bvar:budget?(spent-budget*0.72)/budget*100:0};
}

/* =====================================================================
   MICRO-COMPONENTS
===================================================================== */
function spark(data,color,w=76,h=26){
  const mn=Math.min(...data),mx=Math.max(...data),rg=mx-mn||1;
  const pts=data.map((v,i)=>`${(i/(data.length-1))*w},${h-((v-mn)/rg)*(h-4)-2}`).join(" ");
  return `<svg class="spark" width="${w}" height="${h}" aria-hidden="true"><polyline points="${pts}" fill="none" stroke="${color}" stroke-width="1.8" stroke-linecap="round"/></svg>`;
}
function gauge(val,max,color,label,fmt){
  const p=Math.min(val/max,1), a=Math.PI*(1-p), r=44, cx=55, cy=58;
  const x=cx+r*Math.cos(a), y=cy-r*Math.sin(a);
  const large=p>0.5?1:0;
  return `<div class="gauge"><svg viewBox="0 0 110 66">
    <path d="M11 58 A44 44 0 0 1 99 58" fill="none" stroke="var(--surface-2)" stroke-width="9" stroke-linecap="round"/>
    <path d="M11 58 A44 44 0 ${large} 1 ${x.toFixed(1)} ${y.toFixed(1)}" fill="none" stroke="${color}" stroke-width="9" stroke-linecap="round"/>
  </svg><div class="gv">${fmt||val}</div><div class="gl">${label}</div></div>`;
}
function healthBadge(h){return `<span class="badge b-${h==="Green"?"good":h==="Amber"?"warn":"risk"}">● ${h}</span>`;}
function deltaTag(v,goodUp=true,suffix="%",id){
  //  Modify By Madhuri.K on 01-10-2026 
  const n=Number(v);
  const safe=isFinite(n)?n:0;
  const cls=Math.abs(safe)<0.05?"flat":(safe>0)===goodUp?"up":"down";
  const idAttr=id?` id="${esc(id)}"`:"";
  let icon='<i class="fas fa-minus" aria-hidden="true"></i>';
  if(Math.abs(safe)>=0.05) icon=safe>0?'<i class="fas fa-caret-up" aria-hidden="true"></i>':'<i class="fas fa-caret-down" aria-hidden="true"></i>';
  return `<span class="kpi-delta ${cls}"${idAttr}>${icon} ${Math.abs(safe).toFixed(1)}${suffix}</span>`;
}
function kpiCard(o){
  const valAttr=o.valId?` id="${esc(o.valId)}"`:"";
  //  Modify By Madhuri.K on 01-10-2026 
  const compareOn=!!(typeof DateFilter!=="undefined" && DateFilter.compare)||!!(state.date&&state.date.compare);
  const vsLabel=compareOn
    ?(typeof window.tsCompareTagText==="function"
      ?String(window.tsCompareTagText(DateFilter.selectedComparisonName||state.date.comparisonName||"", state.date.compareMode||"prev")).replace(/^Vs\s+/i,"")
      :compareShortLabel(state.date.compareMode||"prev"))
    :"prev period";
  return `<div class="kpi" role="button" tabindex="0" data-drill="${o.drill||""}" title="Click to drill down">
    <div class="kpi-top"><span class="kpi-label">${o.label}</span>${o.badge||""}</div>
    <div class="kpi-val"${valAttr}>${o.value}</div>
    <div class="kpi-foot" data-kpi-vs="1">${deltaTag(o.delta,o.goodUp!==false,o.suffix,o.trendId)}<span class="kpi-vs">vs ${esc(vsLabel||"prev period")}</span></div>
    ${o.ai?`<div class="kpi-ai"><span class="sp">✦</span><span>${o.ai}</span></div>`:""}
    ${(!isExecPage() && o.spark)?spark(o.spark,o.color||"var(--accent)"):""}
  </div>`;
}
if(typeof encryptString!=="function"){
  window.encryptString=function(value){
    const arr=[]; let n=1, out="";
    const s=String(value==null?"":value);
    for(let i=0;i<s.length;i++){
      arr[i]=String(s.charCodeAt(i)+n);
      n+=2;
    }
    out=arr.join("-");
    if(out.charAt(0)==="-") out=out.substring(1);
    return out;
  };
}
function kpiApiBase(){
  const u=(typeof strUrl!=="undefined" && strUrl)?String(strUrl):"";
  return u.replace(/\/+$/,"");
}
function getTimesheetDashboardId(){
    /* Modify By Madhuri.K On 28-09-2026 */
  if(typeof window!=="undefined" && window.TIMESHEET_DASHBOARD_ID!=null){
    const n=Number(window.TIMESHEET_DASHBOARD_ID);
    if(isFinite(n) && n>0) return n;
  }
  const id=getDashboardId();
    /* Modify By Madhuri.K On 28-09-2026 */
  return id||21041;
}
function getTimesheetUserId(){
  const raw=(typeof SessionEmployeeID!=="undefined"?SessionEmployeeID:0);
  const n=Number(raw);
  return isFinite(n)?n:0;
}
function getTimesheetLoginType(){
  const t=String((typeof SessionLoginType!=="undefined" && SessionLoginType)?SessionLoginType:"E").trim().toUpperCase();
  return (t==="A"||t==="C")?t:"E";
}
function getFilterDashboardId(){
  const id=getDashboardId();
  if(id) return id;
  return isTimesheetPage()?21041:21036;
}
function formatKpiApiDate(d){
  if(!d) return null;
  if(typeof d==="string"){
    const m=d.match(/^(\d{4}-\d{2}-\d{2})/);
    if(m) return m[1];
  }
  const dt=d instanceof Date?d:parseFilterDate(d);
  if(!dt || isNaN(dt.getTime())) return null;
  const m=dt.getMonth()+1, day=dt.getDate();
  return dt.getFullYear()+"-"+(m<10?"0":"")+m+"-"+(day<10?"0":"")+day;
}
function getTimesheetDateFlag(){
  const label=String(DateFilter.selectedFilterName||state.date.label||"").trim();
  if(label.toLowerCase()==="custom") return "0";
  if(label) return label;
    /* Modify By Madhuri.K On 28-09-2026 */
  const id=DateFilter.selectedFilterId!=null?DateFilter.selectedFilterId:state.date.filterId;
  if(id!=null && String(id)!=="" && String(id)!=="0") return resolveDateRangeFlag(String(id));
  return "Current Quarter";
}
function resolveDateRangeFlag(flag){
  const flagVal=flag!=null && flag!==""?String(flag):"";
  if(!flagVal) return flagVal;
  if(flagVal==="0" || flagVal.toLowerCase()==="custom") return "0";
  if(!isTimesheetPage()) return flagVal;
  if(/^\d+$/.test(flagVal)){
    const opt=(DateFilter.dateOptions||[]).find(function(o){ return String(getFilterField(o,"FilterID"))===flagVal; });
    const name=opt?String(getFilterField(opt,"FilterName")||"").trim():"";
    if(name && name.toLowerCase()!=="custom") return name;
  }
  return flagVal;
}
function isTimesheetPage(){
  if(typeof state!=="undefined" && state.page==="timesheets") return true;
  return !!(document.body && document.body.getAttribute("data-page")==="timesheets");
}
/* Shared calendar (app.js) — same on every page:
   Bind API options as returned (incl. Custom). Compare toggle defaults off until user enables it.
   Override only via window.ALLOW_DATE_FILTER_* if a page must hide a feature. */
function isDateFilterCustomEnabled(){
  if(typeof window!=="undefined" && window.ALLOW_DATE_FILTER_CUSTOM===true) return true;
  if(typeof window!=="undefined" && window.ALLOW_DATE_FILTER_CUSTOM===false) return false;
  return true;
}
function isDateFilterCompareEnabled(){
  if(typeof window!=="undefined" && window.ALLOW_DATE_FILTER_COMPARE===true) return true;
  if(typeof window!=="undefined" && window.ALLOW_DATE_FILTER_COMPARE===false) return false;
  return true;
}
function isCustomDateFilterName(name){
  const n=String(name||"").replace(/\s+/g,"").toLowerCase();
  return n==="custom"||n==="customcomparison";
}
function filterDateOptionsForPage(list){
  if(isDateFilterCustomEnabled()) return list||[];
  return (list||[]).filter(function(row){
    return !isCustomDateFilterName(getFilterField(row,"FilterName"));
  });
}
function canUseTimesheetApis(){
  return !!kpiApiBase();
}
function isExecPage(){
  if(typeof state!=="undefined" && state.page==="exec") return true;
  return !!(document.body && document.body.getAttribute("data-page")==="exec");
}
const EXEC_DRILL_MAX_LEVELS=4;
function getDrillLevels(def){
  const levels=(def&&def.levels)||[];
  if(isExecPage() && levels.length>EXEC_DRILL_MAX_LEVELS) return levels.slice(0, EXEC_DRILL_MAX_LEVELS);
  return levels;
}
function canDrillNext(next){
  if(!next) return false;
  if(!isExecPage()) return true;
  return Number(next.level)<EXEC_DRILL_MAX_LEVELS;
}
/* Timesheet KPI / drill / graph chips — Group still sends PortfolioIDs.
   RegionIDs, BillingTypeIDs, HealthIDs match CXO revenue. */
const TIMESHEET_KPI_CHIP_LABELS=["Portfolio","Customer","Project Manager","Health","Organization Unit","Billing Type"];
const TIMESHEET_CHIP_ALIASES={"Region":"Organization Unit"};
/* var (not const) — CXO aspx redeclares TOP_FILTER_CHIPS; const+var across scripts throws and leaves the preloader stuck. */
var TOP_FILTER_CHIPS=[
  {label:"Portfolio", flag:"portfolio"},
  {label:"Customer", flag:"customer"},
  {label:"Project Manager", flag:"projectManager"},
  {label:"Health", flag:"health"},
  {label:"Organization Unit", flag:"region"},
  {label:"Billing Type", flag:"billingType"}
];
/* Cascade from Portfolio — Customer, PM, Health, Region (OU), Billing Type. */
var DEPENDENT_FILTER_FLAGS=["Customer","ProjectManager","Health","Region","BillingType"];
var TopFilter={options:{}, selected:{}, loaded:false, dependentLoading:false, dependentRequestSeq:0};
if(typeof window!=="undefined"){
  window.TopFilter=TopFilter;
  window.TOP_FILTER_CHIPS=TOP_FILTER_CHIPS;
  window.DEPENDENT_FILTER_FLAGS=DEPENDENT_FILTER_FLAGS;
}
function normalizeTopFilterRows(rows){
  const list=[];
  (rows||[]).forEach(row=>{
    const id=getFilterField(row,"id","ID","Id","LocationID","OrganizationUnitID");
    const name=getFilterField(row,"name","Name","LocationName","OrganizationUnitName","OrganizationUnit");
    if(id==null || name==null || name==="") return;
    list.push({id:String(id), name:String(name)});
  });
  return list;
}
function getApiDataBag(json){
  let node=json, depth=0;
  while(node && typeof node==="object" && !Array.isArray(node) && depth<6){
    const keys=Object.keys(node);
    const hit=keys.some(k=>{
      const n=String(k).replace(/\s/g,"").toLowerCase();
      return n==="portfolio"||n==="customer"||n==="projectmanager"||n==="health"||n==="region"||n==="billingtype"||n==="organizationunit";
    });
    if(hit) return node;
    if(node.data!=null && typeof node.data==="object" && !Array.isArray(node.data)){ node=node.data; depth++; continue; }
    if(node.Data!=null && typeof node.Data==="object" && !Array.isArray(node.Data)){ node=node.Data; depth++; continue; }
    break;
  }
  return node && typeof node==="object" && !Array.isArray(node)?node:null;
}
function findTopFilterChip(flagOrLabel){
  if(!flagOrLabel) return null;
  let a=String(flagOrLabel).replace(/\s/g,"").toLowerCase();
  if(a==="organizationunit"||a==="location"||a==="ou") a="region";
  for(let i=0;i<TOP_FILTER_CHIPS.length;i++){
    const chip=TOP_FILTER_CHIPS[i];
    const b=String(chip.flag||"").replace(/\s/g,"").toLowerCase();
    if(chip.label===flagOrLabel||chip.flag===flagOrLabel) return chip;
    if(String(chip.label).replace(/\s/g,"").toLowerCase()===a||b===a) return chip;
  }
  return null;
}
function writeTopFilterSelected(labelOrFlag, arr){
  //  Modify By Madhuri.K on 01-10-2026 
  const chip=findTopFilterChip(labelOrFlag);
  const list=(arr||[]).map(x=>({id:String(x.id), name:String(x.name)}));
  if(!chip){
    TopFilter.selected[labelOrFlag]=list;
    if(state.filters) state.filters[labelOrFlag]=list.map(x=>x.name);
    return;
  }
  TopFilter.selected[chip.label]=list;
  TopFilter.selected[chip.flag]=list;
  if(state.filters) state.filters[chip.label]=list.map(x=>x.name);
}
function findFilterBagKey(bag, flag){
  if(!bag||!flag) return null;
  const aliases=[flag];
  const n=String(flag).replace(/\s/g,"").toLowerCase();
  if(n==="region") aliases.push("OrganizationUnit","Organization Unit","Location","OU");
  if(n==="projectmanager") aliases.push("Project Manager","projectManager","PM");
  if(n==="billingtype") aliases.push("Billing Type","billingType");
  for(let i=0;i<aliases.length;i++){
    const found=Object.keys(bag).find(k=>String(k).replace(/\s/g,"").toLowerCase()===String(aliases[i]).replace(/\s/g,"").toLowerCase());
    if(found) return found;
  }
  return null;
}
function joinSelectedIds(flagOrLabel){
  if(typeof window.joinSelectedIds==="function" && window.joinSelectedIds!==joinSelectedIds){
    try{ return window.joinSelectedIds(flagOrLabel); }catch(e){ /* fall through */ }
  }
  const chip=findTopFilterChip(flagOrLabel);
  const keys=[flagOrLabel];
  if(chip){ keys.push(chip.label, chip.flag); }
  const out=[], seen={};
  keys.forEach(key=>{
    ((TopFilter.selected&&TopFilter.selected[key])||[]).forEach(x=>{
      const id=x&&x.id!=null?String(x.id).trim():"";
      if(!id||seen[id]) return;
      seen[id]=true;
      out.push(id);
    });
  });
  return out.join(",");
}
function supportsDependentFilterApi(){
  const c=String(getFilterApiController()||"").toLowerCase();
  return c.indexOf("analyticscxo")>=0 || c.indexOf("pm_analyticscxo")>=0;
}
function callTopFilterApi(actionName, body, onSuccess, onError){
  /* Prefer page-owned callDashboardApi (CXO aspx) — same auth/path as FlagWise. */
  var pageApi=(typeof window!=="undefined" && typeof window.callDashboardApi==="function")
    ? window.callDashboardApi
    : (typeof callDashboardApi==="function" ? callDashboardApi : null);
  if(pageApi){
    pageApi(actionName, body, onSuccess, onError);
    return;
  }
  if(typeof callFilterDashboardApi==="function" && canUseFilterApis()){
    callFilterDashboardApi(actionName, body, onSuccess, onError);
    return;
  }
  if(onError) onError(new Error("Filter API is not available"));
}
/*
  Purpose: Reload Customer / PM / Health / Region (OU) / Billing by selected Portfolio(s).
  Blank PortfolioIDs → full masters. Drops chip values no longer in the option list.
  Owned by app.js (CXO ASPX + exec.html call this; do not re-implement on aspx).
  Writes options under flag + label + chip.flag so CXO openTopFilterPop (data-flag first) sees cascade.
*/
function LoadDependentTopFilters(portfolioIds, onDone){
  var finished=false;
  /* Prefer shared window.TopFilter (CXO aspx) so cascade writes the same object chips read. */
  if(typeof window!=="undefined" && window.TopFilter) TopFilter=window.TopFilter;
  function done(opts){
    if(finished) return;
    finished=true;
    try{ if(onDone) onDone(opts||(TopFilter&&TopFilter.options)||{}); }catch(e){ console.error(e); }
  }
  try{
    if(!TopFilter || !TopFilter.loaded){
      done(TopFilter&&TopFilter.options);
      return;
    }
    if(isTimesheetPage() && !supportsDependentFilterApi()){
      reloadTimesheetProjectManagers(function(){ done(TopFilter.options); });
      return;
    }
    if(!canUseFilterApis() && typeof callDashboardApi!=="function" && !(typeof window!=="undefined" && typeof window.callDashboardApi==="function")){
      done(TopFilter.options);
      return;
    }
    const seq=++TopFilter.dependentRequestSeq;
    TopFilter.dependentLoading=true;
    const body={
      DashboardID:getFilterDashboardId()||getDashboardId()||(typeof DASHBOARD_ID!=="undefined"?DASHBOARD_ID:0),
      PortfolioIDs:portfolioIds||""
    };
    /* Prefer page-owned helpers (CXO aspx) when present — same unwrap/chip write as FlagWise. */
    const bagFn=(typeof window!=="undefined" && typeof window.getApiDataBag==="function")?window.getApiDataBag:getApiDataBag;
    const normFn=(typeof window!=="undefined" && typeof window.normalizeTopFilterRows==="function")?window.normalizeTopFilterRows:normalizeTopFilterRows;
    const findChipFn=(typeof window!=="undefined" && typeof window.findTopFilterChip==="function")?window.findTopFilterChip:findTopFilterChip;
    const writeSelFn=(typeof window!=="undefined" && typeof window.writeTopFilterSelected==="function")?window.writeTopFilterSelected:writeTopFilterSelected;
    const findKeyFn=(typeof window!=="undefined" && typeof window.findFilterBagKey==="function")?window.findFilterBagKey:findFilterBagKey;
    const rowsFn=(typeof window!=="undefined" && typeof window.getApiRows==="function")?window.getApiRows:getApiRows;
    callTopFilterApi("GetAnalyticsDBFilterFlagWiseDependent", body, function(json){
      try{
        if(seq!==TopFilter.dependentRequestSeq){ done(TopFilter.options); return; }
        const bag=bagFn(json)||{};
        const options=TopFilter.options||{};
        DEPENDENT_FILTER_FLAGS.forEach(flag=>{
          const chip=findChipFn(flag);
          const key=findKeyFn(bag, flag)
            ||(chip?findKeyFn(bag, chip.label):null)
            ||(chip?findKeyFn(bag, chip.flag):null);
          let rows=key?bag[key]:[];
          if(!Array.isArray(rows)) rows=rowsFn(rows);
          const normalized=normFn(rows);
          /* Write label + flag + API key — CXO openTopFilterPop reads data-flag first (may be camelCase). */
          options[flag]=normalized;
          if(chip){
            options[chip.label]=normalized;
            options[chip.flag]=normalized;
          }
          const label=chip?chip.label:flag;
          //  Modify By Madhuri.K on 01-10-2026 — health id/name alias aware prune
          const prevSel=TopFilter.selected[label]
            ||(chip&&TopFilter.selected[chip.flag])
            ||TopFilter.selected[flag]
            ||[];
          const sel=resolveSelectedAgainstOptions(label, prevSel, normalized);
          if(typeof writeSelFn==="function") writeSelFn(label, sel);
          else{
            TopFilter.selected[label]=sel;
            if(chip) TopFilter.selected[chip.flag]=sel;
          }
          if(normalized.length && typeof FILTER_DEFS!=="undefined"){
            FILTER_DEFS[label]=normalized.map(x=>x.name);
          }
        });
        TopFilter.options=options;
        if(typeof window!=="undefined") window.TopFilter=TopFilter;
        TopFilter.dependentLoading=false;
        if(typeof syncTopFilterToAppState==="function") syncTopFilterToAppState();
        else if(typeof window!=="undefined" && typeof window.syncTopFilterToAppState==="function") window.syncTopFilterToAppState();
        if(typeof syncTopFilterChipBadges==="function") syncTopFilterChipBadges();
        else if(typeof window!=="undefined" && typeof window.syncTopFilterChipBadges==="function") window.syncTopFilterChipBadges();
        else if(typeof renderChips==="function") renderChips();
        done(options);
      }catch(err){
        console.error("LoadDependentTopFilters", err);
        TopFilter.dependentLoading=false;
        done(TopFilter.options);
      }
    }, function(){
      if(seq!==TopFilter.dependentRequestSeq){ done(TopFilter.options); return; }
      TopFilter.dependentLoading=false;
      done(TopFilter.options);
    });
  }catch(err){
    console.error("LoadDependentTopFilters", err);
    if(TopFilter) TopFilter.dependentLoading=false;
    done(TopFilter&&TopFilter.options);
  }
}
/* Purpose: After Portfolio chip change — refresh dependent lists then KPIs / page. */
function onPortfolioFilterChanged(thenRefreshKpi){
  if(typeof closeTopFilterPop==="function"){
    try{ closeTopFilterPop(); }catch(e){ /* ignore */ }
  }
  LoadDependentTopFilters(joinSelectedIds("Portfolio"), function(){
    if(typeof syncTopFilterChipBadges==="function") syncTopFilterChipBadges();
    else if(typeof renderChips==="function") renderChips();
    if(typeof persistState==="function") persistState();
    if(thenRefreshKpi===false) return;
    if(typeof RefreshKpiDashboard==="function") RefreshKpiDashboard();
    else if(typeof renderPage==="function") renderPage();
  });
}
function GetTopFilterOption(onDone){
  if(TopFilter.loaded){
    if(onDone) onDone(TopFilter.options);
    return;
  }
  if(!canUseFilterApis() && typeof callDashboardApi!=="function"){
    TopFilter.loaded=false;
    if(onDone) onDone({});
    return;
  }
   /* Modify By Madhuri.K On 28-09-2026 */
  const flagBody={dashboardID:getFilterDashboardId()||getDashboardId()||(typeof DASHBOARD_ID!=="undefined"?DASHBOARD_ID:0)};
  if(isTimesheetPage()){
    flagBody.userID=getTimesheetUserId();
    flagBody.loginType=getTimesheetLoginType();
  }
  callTopFilterApi("GetAnalyticsDBFilterFlagWise", flagBody, function(json){
    const bag=getApiDataBag(json)||{};
    const options={};
    TOP_FILTER_CHIPS.forEach(chip=>{
      const key=findFilterBagKey(bag, chip.flag)||findFilterBagKey(bag, chip.label);
      let rows=key?bag[key]:[];
      if(!Array.isArray(rows)) rows=getApiRows(rows);
      const normalized=normalizeTopFilterRows(rows);
      options[chip.flag]=normalized;
      options[chip.label]=normalized;
      if(!TopFilter.selected[chip.label]) writeTopFilterSelected(chip.label, []);
      if(normalized.length){
        FILTER_DEFS[chip.label]=normalized.map(x=>x.name);
      }
    });
    TopFilter.options=options;
    TopFilter.loaded=true;
    const finish=function(){ if(onDone) onDone(TopFilter.options); };
    if(isTimesheetPage() && !supportsDependentFilterApi()){
      reloadTimesheetProjectManagers(finish);
      return;
    }
    /* Cascade dependents when Portfolio already selected (saved view / restore). */
    LoadDependentTopFilters(joinSelectedIds("Portfolio"), finish);
  }, function(){
    TopFilter.options={};
    TopFilter.loaded=false;
    if(onDone) onDone({});
  });
}
function getTopFilterSelectedCount(label){
  return (TopFilter.selected[label]||[]).length;
}

//  Modify By Madhuri.K on 01-10-2026 
/* Health filterJson may store "Green" while FlagWise options use id "1" (and vice versa). */
function normalizeHealthFilterId(id){
  const s=String(id==null?"":id).trim();
  if(!s) return "";
  if(/^green$/i.test(s)||s==="1") return "1";
  if(/^amber$/i.test(s)||s==="2") return "2";
  if(/^red$/i.test(s)||s==="3") return "3";
  return s;
}
function healthFilterIdsMatch(a,b){
  const na=normalizeHealthFilterId(a), nb=normalizeHealthFilterId(b);
  return !!na && na===nb;
}
/* Map saved {id,name} onto current option list (id, health alias, or name). Keep as-is if options empty. */
function resolveSelectedAgainstOptions(label, selected, options){
  const opts=Array.isArray(options)?options:[];
  const src=Array.isArray(selected)?selected:[];
  if(!src.length) return [];
  if(!opts.length){
    return src.map(x=>({id:String(x.id), name:String(x.name!=null?x.name:x.id)}));
  }
  const out=[];
  const seen={};
  src.forEach(sel=>{
    if(sel==null) return;
    const sid=String(sel.id!=null?sel.id:"");
    const sname=String(sel.name!=null?sel.name:"").trim();
    let match=opts.find(o=>String(o.id)===sid);
    if(!match && label==="Health"){
      match=opts.find(o=>
        healthFilterIdsMatch(o.id, sid) ||
        healthFilterIdsMatch(o.name, sid) ||
        healthFilterIdsMatch(o.id, sname) ||
        healthFilterIdsMatch(o.name, sname)
      );
    }
    if(!match && sname){
      match=opts.find(o=>String(o.name||"").toLowerCase()===sname.toLowerCase());
    }
    if(!match) return;
    const key=String(match.id);
    if(seen[key]) return;
    seen[key]=true;
    out.push({id:String(match.id), name:String(match.name)});
  });
  return out;
}
//  Modify By Madhuri.K on 01-10-2026 
/* Build chip map for SaveUserFilter — merge TopFilter.selected + state.filters name fallback. */
function collectTopFilterSelectionMap(){
  const selected={};
  TOP_FILTER_CHIPS.forEach(chip=>{
    const opts=TopFilter.options[chip.label]||TopFilter.options[chip.flag]||[];
    let list=(TopFilter.selected[chip.label]||TopFilter.selected[chip.flag]||[]).slice();
    const names=(state.filters&&state.filters[chip.label])||[];
    if(names.length){
      names.forEach(function(name){
        const n=String(name||"").trim();
        if(!n) return;
        const already=list.some(function(x){
          return String(x.name).toLowerCase()===n.toLowerCase()
            || String(x.id).toLowerCase()===n.toLowerCase()
            || (chip.label==="Health" && healthFilterIdsMatch(x.id, n));
        });
        if(already) return;
        const opt=opts.find(function(o){
          return String(o.name).toLowerCase()===n.toLowerCase()
            || String(o.id).toLowerCase()===n.toLowerCase()
            || (chip.label==="Health" && (healthFilterIdsMatch(o.id, n)||healthFilterIdsMatch(o.name, n)));
        });
        list.push(opt?{id:String(opt.id), name:String(opt.name)}:{id:n, name:n});
      });
    }
    selected[chip.label]=resolveSelectedAgainstOptions(chip.label, list, opts);
  });
  return selected;
}
function isTopFilterSelected(label, id){
  //  Modify By Madhuri.K on 01-10-2026 
  const chip=findTopFilterChip(label);
  const key=chip?chip.label:label;
  const arr=TopFilter.selected[key]||(chip&&TopFilter.selected[chip.flag])||[];
  const oid=String(id);
  return arr.some(x=>{
    if(String(x.id)===oid) return true;
    if(key==="Health" && (healthFilterIdsMatch(x.id, oid)||healthFilterIdsMatch(x.name, oid))) return true;
    return false;
  });
}
function toggleTopFilterSelection(label, item){
  //  Modify By Madhuri.K on 01-10-2026 
  const chip=findTopFilterChip(label);
  const key=chip?chip.label:label;
  const arr=(TopFilter.selected[key]||[]).slice();
  const idx=arr.findIndex(x=>String(x.id)===String(item.id) || (key==="Health" && healthFilterIdsMatch(x.id, item.id)));
  if(idx>=0) arr.splice(idx,1);
  else arr.push({id:String(item.id), name:String(item.name)});
  //  Modify By Madhuri.K on 01-10-2026 
  writeTopFilterSelected(key, arr);
}
  /* Modify By Madhuri.K On 28-09-2026 */
function reloadTimesheetProjectManagers(onDone){
  const finish=function(){ if(onDone) onDone(); };
  if(!isTimesheetPage() || !canUseFilterApis()){ finish(); return; }
  const chips=timesheetChipFilterBag();
  callFilterDashboardApi("GetAnalyticsDBFilterFlagWise", {
    dashboardID:getTimesheetDashboardId(),
    flag:"ProjectManager",
    portfolioIDs:chips.portfolioIDs||"",
    customerIDs:chips.customerIDs||"",
    userID:getTimesheetUserId(),
    loginType:getTimesheetLoginType()
  }, function(json){
    const bag=getApiDataBag(json)||{};
    const key=Object.keys(bag).find(k=>String(k).replace(/\s/g,"").toLowerCase()==="projectmanager");
    let rows=key?bag[key]:[];
    if(!Array.isArray(rows)) rows=getApiRows(rows);
    rows=normalizeTopFilterRows(rows);
    TopFilter.options["Project Manager"]=rows;
    if(rows.length) FILTER_DEFS["Project Manager"]=rows.map(x=>x.name);
    const allow={};
    rows.forEach(function(r){ allow[String(r.id)]=true; });
    TopFilter.selected["Project Manager"]=(TopFilter.selected["Project Manager"]||[]).filter(function(x){ return !!allow[String(x.id)]; });
    syncTopFilterToAppState();
    finish();
  }, function(){ finish(); });
}
function syncTopFilterToAppState(){
  if(!state.filters) return;
  TOP_FILTER_CHIPS.forEach(chip=>{
    const arr=TopFilter.selected[chip.label]||[];
    state.filters[chip.label]=arr.map(x=>x.name);
  });
}
function clearTopFilterSelections(){
  TOP_FILTER_CHIPS.forEach(chip=>{ TopFilter.selected[chip.label]=[]; });
  syncTopFilterToAppState();
}
function getTimesheetChipCsv(filterKey){
  const label=TIMESHEET_CHIP_ALIASES[filterKey]||filterKey;
  if(TIMESHEET_KPI_CHIP_LABELS.indexOf(label)<0 && TIMESHEET_KPI_CHIP_LABELS.indexOf(filterKey)<0) return "";
  const arr=TopFilter.selected[label]||TopFilter.selected[filterKey]||[];
  if(arr.length) return arr.map(x=>String(x.id)).join(",");
  /* Fallback: numeric values already stored as IDs in state.filters */
  const vals=(state.filters&&(state.filters[label]||state.filters[filterKey]))||[];
  if(vals.length && vals.every(v=>/^\d+$/.test(String(v)))) return vals.join(",");
  return "";
}
function timesheetChipFilterBag(src){
  const f=src||{};
  const healthRaw=f.healthIDs!=null?String(f.healthIDs):getTimesheetChipCsv("Health");
  return {
    portfolioIDs:f.portfolioIDs!=null?String(f.portfolioIDs):getTimesheetChipCsv("Portfolio"),
    customerIDs:f.customerIDs!=null?String(f.customerIDs):getTimesheetChipCsv("Customer"),
    projectManagerIDs:f.projectManagerIDs!=null?String(f.projectManagerIDs):getTimesheetChipCsv("Project Manager"),
    regionIDs:f.regionIDs!=null?String(f.regionIDs):getTimesheetChipCsv("Organization Unit"),
    billingTypeIDs:f.billingTypeIDs!=null?String(f.billingTypeIDs):getTimesheetChipCsv("Billing Type"),
    healthIDs:String(healthRaw||"").split(",").map(s=>s.trim()).filter(Boolean).map(id=>{
      if(/^green$/i.test(id)||id==="1") return "1";
      if(/^amber$/i.test(id)||id==="2") return "2";
      if(/^red$/i.test(id)||id==="3") return "3";
      return id;
    }).join(",")
  };
}
function resetTimesheetDrill(){
  if(window.TimesheetDrill && typeof TimesheetDrill.reset==="function"){
    TimesheetDrill.reset();
  }else{
    TimesheetDrillState={apiName:null,level:1,portfolioID:0,projectID:0,employeeID:0,stack:[]};
    const ov=document.getElementById("overlay");
    if(ov) ov.classList.remove("open");
  }
  if(typeof setTrail==="function") setTrail([]);
}
var TimesheetKpiState={
  currentFromDate:null,
  currentToDate:null,
  previousFromDate:null,
  previousToDate:null,
  lastKpi:null
};
function storeTimesheetKpiDates(kpi){
  if(!kpi) return;
  TimesheetKpiState.lastKpi=kpi;
  TimesheetKpiState.currentFromDate=formatKpiApiDate(pickKpiField(kpi,"current_StartDate","Current_StartDate","currentStartDate"));
  TimesheetKpiState.currentToDate=formatKpiApiDate(pickKpiField(kpi,"current_EndDate","Current_EndDate","currentEndDate"));
  TimesheetKpiState.previousFromDate=formatKpiApiDate(pickKpiField(kpi,"previous_StartDate","Previous_StartDate","previousStartDate"));
  TimesheetKpiState.previousToDate=formatKpiApiDate(pickKpiField(kpi,"previous_EndDate","Previous_EndDate","previousEndDate"));
   /* Modify By Madhuri.K On 28-09-2026 */
  TimesheetKpiState.slaThresholdDays=pickKpiField(kpi,"sla_Threshold_Days","SLA_Threshold_Days","slaThresholdDays");
  TimesheetKpiState.productivityNormSet=pickKpiField(kpi,"productivity_Norm_Set","Productivity_Norm_Set","productivityNormSet");
  if(TimesheetKpiState.currentFromDate){
    DateFilter.startDate=parseFilterDate(TimesheetKpiState.currentFromDate);
    state.date.s=DateFilter.startDate;
  }
  if(TimesheetKpiState.currentToDate){
    DateFilter.endDate=parseFilterDate(TimesheetKpiState.currentToDate);
    state.date.e=DateFilter.endDate;
  }
  if(TimesheetKpiState.previousFromDate){
    DateFilter.previousStart=parseFilterDate(TimesheetKpiState.previousFromDate);
    state.date.cs=DateFilter.previousStart;
  }
  if(TimesheetKpiState.previousToDate){
    DateFilter.previousEnd=parseFilterDate(TimesheetKpiState.previousToDate);
    state.date.ce=DateFilter.previousEnd;
  }
  if(TimesheetKpiState.currentFromDate && TimesheetKpiState.currentToDate){
    state.date.range=rangeLbl(state.date.s, state.date.e);
    if(typeof syncDateUI==="function") syncDateUI();
  }
}
function pickKpiField(obj){
  if(!obj || typeof obj!=="object") return undefined;
  for(let i=1;i<arguments.length;i++){
    const key=arguments[i];
    if(Object.prototype.hasOwnProperty.call(obj,key) && obj[key]!==undefined && obj[key]!==null && obj[key]!=="") return obj[key];
    if(Object.prototype.hasOwnProperty.call(obj,key) && typeof obj[key]==="number") return obj[key];
  }
  const wanted=String(arguments[1]||"").replace(/_/g,"").toLowerCase();
  const keys=Object.keys(obj);
  for(let i=0;i<keys.length;i++){
    if(keys[i].replace(/_/g,"").toLowerCase()===wanted && obj[keys[i]]!==undefined && obj[keys[i]]!==null) return obj[keys[i]];
  }
  return undefined;
}
function isTimesheetKpiRecord(obj){
  if(!obj || typeof obj!=="object" || Array.isArray(obj)) return false;
  return pickKpiField(obj,"submitted_Percent","pending_Count","billable_Hours_HHMM","productivity_Index")!==undefined;
}
function parseKpiNode(node){
  if(typeof node!=="string") return node;
  const t=node.trim();
  if(!t || (t.charAt(0)!=="{" && t.charAt(0)!=="[")) return node;
  try{ return JSON.parse(t); }catch(err){ return node; }
}
function unwrapKpiSummary(json){
  function walk(node, depth){
    node=parseKpiNode(node);
    if(!node || typeof node!=="object" || depth>8) return null;
    const status=node.status||node.Status;
    if(status && String(status).toUpperCase()==="FAILURE"){
      throw new Error(node.message||node.Message||"GetKpiSummary failed");
    }
    if(Array.isArray(node)){
      for(let i=0;i<node.length;i++){
        const found=walk(node[i], depth+1);
        if(found) return found;
      }
      return null;
    }
    if(isTimesheetKpiRecord(node)) return node;
    const nested=node.data!==undefined?node.data:(node.Data!==undefined?node.Data:undefined);
    if(nested!=null && nested!==node){
      const found=walk(nested, depth+1);
      if(found) return found;
    }
    const keys=Object.keys(node);
    for(let i=0;i<keys.length;i++){
      const k=keys[i];
      if(k==="status"||k==="Status"||k==="message"||k==="Message") continue;
      const found=walk(node[k], depth+1);
      if(found) return found;
    }
    return null;
  }
  return walk(json, 0);
}
function formatKpiPercent(n){
  const v=Number(n);
  if(!isFinite(v)) return "0.00%";
  return v.toFixed(2)+"%";
}
function formatKpiCount(n){
  const v=Number(n);
  if(!isFinite(v)) return "0";
  return String(Math.round(v));
}
function formatKpiIndex(n){
  const v=Number(n);
  if(!isFinite(v)) return "0.00";
  return String(Number(v.toFixed(4)));
}
function formatKpiHours(v){
  if(v==null || v==="") return "0:00";
  const s=String(v).trim();
  const hm=s.match(/^(-?)(\d+):([0-5]?\d)$/);
  if(hm){
    const mins=String(Number(hm[3])).padStart(2,"0");
    return hm[1]+String(Number(hm[2]))+":"+mins;
  }
  const n=Number(String(s).replace(/,/g,""));
  if(!isFinite(n)) return "0:00";
  const sign=n<0?"-":"";
  const total=Math.round(Math.abs(n)*60);
  const h=Math.floor(total/60);
  const m=total%60;
  return sign+h+":"+String(m).padStart(2,"0");
}
function formatKpiTrend(vsPct){
  //  Modify By Madhuri.K on 01-10-2026 
  /* Same idea as CXO formatKpiDeltaHtml: always show a pill (flat 0% / up / down), never a bare "—". */
  let n=0;
  if(vsPct!=null && vsPct!==""){
    const parsed=Number(vsPct);
    if(isFinite(parsed)) n=parsed;
  }
  if(!isFinite(n) || Math.abs(n)<0.05) return {text:'<i class="fas fa-minus" aria-hidden="true"></i> 0.00%',cls:"flat",html:true};
  if(n>0) return {text:'<i class="fas fa-caret-up" aria-hidden="true"></i> '+Math.abs(n).toFixed(2)+"%",cls:"up",html:true};
  return {text:'<i class="fas fa-caret-down" aria-hidden="true"></i> '+Math.abs(n).toFixed(2)+"%",cls:"down",html:true};
}
function timesheetComplianceNoteHtml(kpi){
  const people=pickKpiField(kpi||{},
    "people_Count","People_Count","peopleCount",
    "resource_Count","Resource_Count","resourceCount",
    "employee_Count","Employee_Count","employeeCount",
    "headcount","Headcount");
  const sample=pickKpiField(kpi||{},
    "sample_Resource_Count","Sample_Resource_Count","sampleResourceCount");
  const scale=pickKpiField(kpi||{},
    "scale_Factor","Scale_Factor","scaleFactor");
  const peopleN=(people!=null && people!=="" && isFinite(Number(people)))?String(Math.round(Number(people))):"412";
  const sampleN=(sample!=null && sample!=="" && isFinite(Number(sample)))?String(Math.round(Number(sample))):"12";
  let scaleN="34.3";
  if(scale!=null && scale!=="" && isFinite(Number(scale))){
    const s=Number(scale);
    scaleN=Math.abs(s-Math.round(s))<1e-6?String(Math.round(s)):String(Number(s.toFixed(1)));
  }
  return `<b>${esc(peopleN)}</b> People · Submission, Approval And Effort Mix · Sample Of <b>${esc(sampleN)}</b> Resource Records Scaled ×<b>${esc(scaleN)}</b>`;
}
function setKpiText(id,text){
  const el=document.getElementById(id);
  if(el) el.textContent=text==null?"":String(text);
}
function setKpiTrend(id,vsPct){
  const el=document.getElementById(id);
  if(!el) return;
  const t=formatKpiTrend(vsPct);
  el.className="kpi-delta "+t.cls;
  if(t.html) el.innerHTML=t.text;
  else el.textContent=t.text;
}
function bindTimesheetKpis(kpi){
  //  Modify By Madhuri.K on 01-10-2026 
  /* Card bind lives on Resource_Timesheet_Dash.aspx (tsBindTimesheetKpis). */
  if(typeof window.tsBindTimesheetKpis==="function"){
    window.tsBindTimesheetKpis(kpi);
    return;
  }
  kpi=unwrapKpiSummary(kpi)||kpi;
  if(!isTimesheetKpiRecord(kpi)) return;
  storeTimesheetKpiDates(kpi);
  setKpiText("kpi-submitted-val", formatKpiPercent(pickKpiField(kpi,"submitted_Percent","Submitted_Percent","submittedPercent")));
  setKpiTrend("kpi-submitted-trend", pickKpiField(kpi,"submitted_Vs_Percent","Submitted_Vs_Percent","submittedVsPercent"));
  setKpiText("kpi-pending-val", formatKpiCount(pickKpiField(kpi,"pending_Count","Pending_Count","pendingCount")));
  setKpiTrend("kpi-pending-trend", pickKpiField(kpi,"pending_Vs_Percent","Pending_Vs_Percent","pendingVsPercent"));
  setKpiText("kpi-rejected-val", formatKpiCount(pickKpiField(kpi,"rejected_Count","Rejected_Count","rejectedCount")));
  setKpiTrend("kpi-rejected-trend", pickKpiField(kpi,"rejected_Vs_Percent","Rejected_Vs_Percent","rejectedVsPercent"));
  setKpiText("kpi-sla-val", formatKpiPercent(pickKpiField(kpi,"sla_Met_Percent","slA_Met_Percent","SLA_Met_Percent","slaMetPercent")));
  setKpiTrend("kpi-sla-trend", pickKpiField(kpi,"sla_Met_Vs_Percent","slA_Met_Vs_Percent","SLA_Met_Vs_Percent","slaMetVsPercent"));
  const billHhmm=pickKpiField(kpi,"billable_Hours_HHMM","Billable_Hours_HHMM","billableHoursHhmm","billableHoursHHMM");
  const nonBillHhmm=pickKpiField(kpi,"nonBillable_Hours_HHMM","NonBillable_Hours_HHMM","nonBillableHoursHhmm");
  setKpiText("kpi-billable-val", formatKpiHours(billHhmm!=null?billHhmm:pickKpiField(kpi,"billable_Hours","Billable_Hours","billableHours")));
  setKpiTrend("kpi-billable-trend", pickKpiField(kpi,"billable_Vs_Percent","Billable_Vs_Percent","billableVsPercent"));
  setKpiText("kpi-nonbillable-val", formatKpiHours(nonBillHhmm!=null?nonBillHhmm:pickKpiField(kpi,"nonBillable_Hours","NonBillable_Hours","nonBillableHours")));
  setKpiTrend("kpi-nonbillable-trend", pickKpiField(kpi,"nonBillable_Vs_Percent","NonBillable_Vs_Percent","nonBillableVsPercent"));
  const ot=pickKpiField(kpi,"overtime_Hours","Overtime_Hours","overtimeHours");
  setKpiText("kpi-overtime-val", formatKpiIndex(ot)+" h");
  setKpiTrend("kpi-overtime-trend", pickKpiField(kpi,"overtime_Vs_Percent","Overtime_Vs_Percent","overtimeVsPercent"));
  setKpiText("kpi-productivity-val", formatKpiIndex(pickKpiField(kpi,"productivity_Index","Productivity_Index","productivityIndex")));
  setKpiTrend("kpi-productivity-trend", pickKpiField(kpi,"productivity_Vs_Percent","Productivity_Vs_Percent","productivityVsPercent"));
   /* Modify By Madhuri.K On 28-09-2026 */
  if(TimesheetKpiState.slaThresholdDays!=null && TimesheetKpiState.slaThresholdDays!==""){
    document.body.setAttribute("data-sla-threshold-days", String(TimesheetKpiState.slaThresholdDays));
    const slaEl=document.getElementById("kpi-sla-val");
    if(slaEl) slaEl.title="SLA threshold: "+TimesheetKpiState.slaThresholdDays+" day(s)";
  }
  if(TimesheetKpiState.productivityNormSet!=null && TimesheetKpiState.productivityNormSet!==""){
    document.body.setAttribute("data-productivity-norm", String(TimesheetKpiState.productivityNormSet));
    const prodEl=document.getElementById("kpi-productivity-val");
    if(prodEl) prodEl.title="Productivity norm: "+TimesheetKpiState.productivityNormSet;
  }
  const rangeEl=document.getElementById("tsPageRange");
  if(rangeEl){
    rangeEl.innerHTML=timesheetComplianceNoteHtml(kpi);
  }
  if(typeof window.tsAfterKpiBind==="function") window.tsAfterKpiBind(kpi);
}
function buildKpiSummaryPayload(filterCriteria){
  const f=filterCriteria||{};
  const flag=f.flag!=null?String(f.flag):getTimesheetDateFlag();
  const isCustom=flag==="0";
  const start=f.startDate!=null?formatKpiApiDate(f.startDate):formatKpiApiDate(DateFilter.startDate||state.date.s);
  const end=f.endDate!=null?formatKpiApiDate(f.endDate):formatKpiApiDate(DateFilter.endDate||state.date.e);
  const userRaw=f.intUserID!=null?f.intUserID:getTimesheetUserId();
  const userId=Number(userRaw);
  const chips=timesheetChipFilterBag(f);
  /* KPI cards always vs previous period (CXO always sends PreviousFrom/To). */
  //  Modify By Madhuri.K on 01-10-2026 
  const cmpName=DateFilter.selectedComparisonName||state.date.comparisonName||"previous period";
  let cmpId=Number(f.comparisonID!=null?f.comparisonID:(DateFilter.selectedComparisonId||state.date.comparisonId||0))||0;
  if(!cmpId && DateFilter.comparisonOptions && DateFilter.comparisonOptions.length){
    cmpId=Number(getFilterField(DateFilter.comparisonOptions[0],"FilterID"))||0;
  }
  const cmpStart=formatKpiApiDate(f.comparisonStartDate||DateFilter.previousStart||state.date.cs||start);
  const cmpEnd=formatKpiApiDate(f.comparisonEndDate||DateFilter.previousEnd||state.date.ce||end);
  const payload={
    flag:isCustom?"0":flag,
    startDate:start,
    endDate:end,
    dashboardID:f.dashboardID!=null?Number(f.dashboardID):getTimesheetDashboardId(),
    portfolioIDs:chips.portfolioIDs,
    customerIDs:chips.customerIDs,
    projectManagerIDs:chips.projectManagerIDs,
    regionIDs:chips.regionIDs,
    billingTypeIDs:chips.billingTypeIDs,
    healthIDs:chips.healthIDs,
    intUserID:isFinite(userId)?userId:0,
    loginType:f.loginType!=null?String(f.loginType):getTimesheetLoginType(),
    //  Modify By Madhuri.K on 01-10-2026 
    isComparison:true,
    comparisonID:cmpId,
    comparisonStartDate:cmpStart,
    comparisonEndDate:cmpEnd
  };
  if(typeof window!=="undefined"){
    window.TimesheetCompareState=window.TimesheetCompareState||{};
    TimesheetCompareState.isComparison=true;
    TimesheetCompareState.comparisonID=payload.comparisonID||0;
    TimesheetCompareState.comparisonName=cmpName||"previous period";
    TimesheetCompareState.comparisonStartDate=payload.comparisonStartDate||"";
    TimesheetCompareState.comparisonEndDate=payload.comparisonEndDate||"";
  }
  return payload;
}
function getTimesheetApiController(){
  if(typeof window!=="undefined" && window.TIMESHEET_API_CONTROLLER)
    return String(window.TIMESHEET_API_CONTROLLER).replace(/^\/+|\/+$/g,"");
  return "TimesheetDashboard";
}
function timesheetApiPost(actionName, payload){
  const body=JSON.stringify(payload||{});
  const headers={
    "Content-Type":"application/json",
    "Authorization":"bearer "+(sessionStorage.getItem("access_token_W27_Dashboard")||"")
  };
  if(typeof encryptString==="function") headers.Params=encryptString(body);
  const base=kpiApiBase();
  if(!base) return Promise.reject(new Error("API base URL is not configured"));
  return fetch(encodeURI(base)+"/api/"+getTimesheetApiController()+"/"+actionName,{
    method:"POST",
    headers:headers,
    body:body
  }).then(res=>{
    return res.json().catch(()=>({})).then(json=>{
      if(!res.ok){
        const msg=(json&&(json.message||json.Message))||(actionName+" failed: "+res.status);
        throw new Error(msg);
      }
      return json;
    });
  });
}
function fetchKpiSummary(filterCriteria){
  return timesheetApiPost("GetKpiSummary", buildKpiSummaryPayload(filterCriteria))
    .then(json=>unwrapKpiSummary(json));
}
let kpiSummarySeq=0;
function loadDashboardKPIs(filterCriteria){
  const seq=++kpiSummarySeq;
  //  Modify By Madhuri.K on 01-10-2026 
  if(isTimesheetPage() && typeof window.tsOnKpiLoadStart==="function"){
    try{ window.tsOnKpiLoadStart(); }catch(err){}
  }
  const finishUi=function(){
    if(isTimesheetPage() && typeof window.tsOnKpiLoadEnd==="function"){
      try{ window.tsOnKpiLoadEnd(); }catch(err){}
    }
  };
  const apply=function(kpi){
    if(seq!==kpiSummarySeq) return kpi;
    if(!document.getElementById("kpi-submitted-val")) return kpi;
    bindTimesheetKpis(kpi);
    if(typeof window.loadTimesheetGraphs==="function") window.loadTimesheetGraphs();
    return kpi;
  };
  return fetchKpiSummary(filterCriteria).then(apply).catch(err=>{
    console.error("GetKpiSummary", err);
    if(typeof toast==="function") toast((err&&err.message)||"Unable to load timesheet KPIs");
    //  Modify By Madhuri.K on 01-10-2026 
    if(seq===kpiSummarySeq && document.getElementById("kpi-submitted-val")){
      bindTimesheetKpis(null);
    }
    return null;
  }).then(function(kpi){
    if(seq===kpiSummarySeq) finishUi();
    return kpi;
  });
}
/* Timesheet drill-down lives on Resource_Timesheet_Dash.aspx (inline), same pattern as CXO. */
window.loadDashboardKPIs=loadDashboardKPIs;
window.timesheetChipFilterBag=timesheetChipFilterBag;
  /* Modify By Madhuri.K On 28-09-2026 */
window.getTimesheetDashboardId=getTimesheetDashboardId;
window.getTimesheetUserId=getTimesheetUserId;
window.getTimesheetLoginType=getTimesheetLoginType;
window.reloadTimesheetProjectManagers=reloadTimesheetProjectManagers;
window.GetTopFilterOption=GetTopFilterOption;
window.GetFilterOption=GetFilterOption;
window.DEPENDENT_FILTER_FLAGS=DEPENDENT_FILTER_FLAGS;
window.LoadDependentTopFilters=LoadDependentTopFilters;
window.onPortfolioFilterChanged=onPortfolioFilterChanged;
/* Stable names for CXO aspx bridges (aspx redeclares LoadDependentTopFilters / onPortfolioFilterChanged). */
window.AppLoadDependentTopFilters=LoadDependentTopFilters;
window.AppOnPortfolioFilterChanged=onPortfolioFilterChanged;
window.findTopFilterChip=findTopFilterChip;
window.writeTopFilterSelected=writeTopFilterSelected;
window.findFilterBagKey=findFilterBagKey;
window.joinSelectedIds=joinSelectedIds;
window.GetFilterDateRange=GetFilterDateRange;
window.GetFilterCompareDateRange=GetFilterCompareDateRange;
window.InitSharedDateFilter=InitSharedDateFilter;
let WID=0;
function widgetToolIcon(faClass, fallbackText){
  // Analytics PVA pages load Font Awesome; other pages fall back to ASCII-safe text.
  if(document.body && document.body.classList.contains("analytics-pva")){
    return `<i class="fas ${faClass}" aria-hidden="true"></i>`;
  }
  return fallbackText;
}
function widget(title,sub,body,opts={}){
  const id="w"+(++WID);
    /* Modify By Madhuri.K On 28-09-2026 */
  const refreshClick=opts.tsGraph
    ? `refreshTimesheetWidget(event,'${opts.tsGraph}')`
    : "refreshDashboardData(event)";
  return `<div class="widget" id="${id}">
    <div class="w-hd"><div><div class="w-title">${title}</div>${sub?`<div class="w-sub">${sub}</div>`:""}</div>
      <div class="w-tools">
        ${opts.drill?`<button type="button" class="w-tool" title="Drill down" onclick="drill('${opts.drill}')">${widgetToolIcon("fa-level-down-alt","Drill")}</button>`:""}
        <button type="button" class="w-tool" title="Refresh" onclick="${refreshClick}">${widgetToolIcon("fa-sync-alt","Ref")}</button>
        <button type="button" class="w-tool" title="Export / Share" onclick="exportMenu(event,'${id}')">${widgetToolIcon("fa-share-alt","Share")}</button>
        <button type="button" class="w-tool w-tool-fs" title="Expand to full screen" onclick="toggleFS('${id}')">${widgetToolIcon("fa-expand","Full")}</button>
      </div></div>
    <div class="w-body">${body}</div></div>`;
}
function syncFsButton(el,open){
  const btn=el && el.querySelector(".w-tool-fs");
  if(!btn) return;
  btn.title=open?"Close":"Expand to full screen";
  btn.setAttribute("aria-label",btn.title);
  btn.innerHTML=widgetToolIcon(open?"fa-times":"fa-expand", open?"Close":"Full");
}
function closeWidgetFS(){
  $$(".widget-fs-clone").forEach(x=>x.remove());
  const backdrop=$("#widgetFsBackdrop");
  if(backdrop) backdrop.remove();
  document.body.classList.remove("widget-fs-open");
  if(typeof window.tsOnFsClose==="function") window.tsOnFsClose();
}
function copyWidgetCanvases(src,clone){
  const from=src.querySelectorAll("canvas");
  const to=clone.querySelectorAll("canvas");
  from.forEach((c,i)=>{
    const d=to[i];
    if(!d) return;
    try{
      d.width=c.width;
      d.height=c.height;
      d.getContext("2d").drawImage(c,0,0);
      if(d.closest(".doughnut-box")){
        d.style.width="auto";
        d.style.height="100%";
        d.style.maxWidth="100%";
        d.style.aspectRatio="1 / 1";
        d.style.objectFit="contain";
        d.style.display="block";
        d.style.margin="0 auto";
      }
    }catch(err){}
  });
}
  /* Modify By Madhuri.K On 28-09-2026 */
function stripTimesheetFsTools(clone){
  if(!clone || !isTimesheetPage()) return;
  if(typeof window.tsStripFsTools==="function"){
    window.tsStripFsTools(clone);
    return;
  }
  clone.querySelectorAll(".w-tool").forEach(btn=>{
    if(btn.classList.contains("w-tool-fs")) return;
    const title=String(btn.getAttribute("title")||"").toLowerCase();
    const oc=String(btn.getAttribute("onclick")||"");
    if(/refresh/.test(title) || /refreshTimesheetWidget|refreshDashboardData/.test(oc)){
      btn.remove();
    }
  });
}
function toggleFS(id){
  const src=document.getElementById(id);
  const openClone=document.querySelector(".widget-fs-clone");
  if(openClone){
    const wasSame=openClone.getAttribute("data-fs-src")===id;
    closeWidgetFS();
    if(wasSame || !src) return;
  }
  if(!src) return;
  let backdrop=$("#widgetFsBackdrop");
  if(!backdrop){
    backdrop=document.createElement("div");
    backdrop.id="widgetFsBackdrop";
    backdrop.className="widget-fs-backdrop";
    backdrop.onclick=function(){ closeWidgetFS(); };
    document.body.appendChild(backdrop);
  }
  const clone=src.cloneNode(true);
  clone.classList.add("fs","widget-fs-clone");
  clone.setAttribute("data-fs-src",id);
  clone.id=id+"-fsclone";
  clone.querySelectorAll("[id]").forEach(function(n){
    if(n!==clone && n.id) n.id=n.id+"-fsclone";
  });
    /* Modify By Madhuri.K On 28-09-2026 */
  stripTimesheetFsTools(clone);
  const fsBtn=clone.querySelector(".w-tool-fs");
  if(fsBtn){
    fsBtn.setAttribute("onclick","toggleFS('"+id.replace(/'/g,"")+"')");
    syncFsButton(clone,true);
  }
  document.body.appendChild(clone);
  document.body.classList.add("widget-fs-open");
  if(typeof window.tsOnFsOpen==="function") window.tsOnFsOpen(clone, id, src);
  requestAnimationFrame(function(){
    copyWidgetCanvases(src,clone);
    requestAnimationFrame(function(){ copyWidgetCanvases(src,clone); });
  });
}

function csvCell(v){
  const s=String(v==null?"":v);
  return /[",\n]/.test(s)?'"'+s.replace(/"/g,'""')+'"':s;
}
function downloadBlob(content,filename,mime){
  const blob=content instanceof Blob?content:new Blob([content],{type:mime||"application/octet-stream"});
  const a=document.createElement("a");
  a.href=URL.createObjectURL(blob);
  a.download=filename;
  a.rel="noopener";
  document.body.appendChild(a);
  a.click();
  setTimeout(()=>{URL.revokeObjectURL(a.href);a.remove();},2000);
}
function chartPNG(ch){
  try{
    if(ch && typeof ch.toBase64Image==="function") return ch.toBase64Image("image/png",1);
    if(ch && ch.canvas) return ch.canvas.toDataURL("image/png");
  }catch(err){}
  return "";
}
function collectDashboardCharts(){
  const imgs=[];
  document.querySelectorAll("#page-"+state.page+" canvas").forEach(cv=>{
    try{
      const ch=state.charts[cv.id];
      const src=ch?chartPNG(ch):cv.toDataURL("image/png");
      if(!src || src.length<80) return;
      const title=(cv.closest(".widget") && cv.closest(".widget").querySelector(".w-title"))
        ? cv.closest(".widget").querySelector(".w-title").textContent
        : (cv.id||"Chart");
      imgs.push({title,src});
    }catch(err){}
  });
  return imgs;
}
function pageHeaderFileName(){
  const h2=document.querySelector(".page-header-section h2");
  let name="";
  if(h2) name=h2.innerText.replace(/\s+/g," ").trim();
  if(!name){
    const crumb=document.getElementById("crumbPage");
    if(crumb) name=crumb.textContent.replace(/\s+/g," ").trim();
  }
  if(!name) name=(typeof PAGE_NAMES!=="undefined" && PAGE_NAMES[state.page])||"Dashboard";
  return name.replace(/[\\/:*?"<>|]+/g," ").replace(/\s+/g," ").trim()||"Dashboard";
}
function htmlExportFileName(){
  const base=pageHeaderFileName().replace(/&/g,"and").replace(/[^A-Za-z0-9]+/g,"_").replace(/_+/g,"_").replace(/^_|_$/g,"");
  const d=new Date();
  const pad=n=>String(n).padStart(2,"0");
  const stamp=d.getFullYear()+"-"+pad(d.getMonth()+1)+"-"+pad(d.getDate())+"_"+pad(d.getHours())+"-"+pad(d.getMinutes());
  return base+"_"+stamp+".html";
}
function dashboardExportPayload(){
  const a=agg();
  const headerName=pageHeaderFileName();
  const title=headerName+" — "+state.date.label;
  const kpiRows=[
    ["KPI","Value"],
    ["Revenue",cr(a.rev)],["Gross profit",cr(a.gp)],["Gross margin",pct(a.margin)],
    ["EBIT",cr(a.ebit)],["Net profit",cr(a.np)],["Utilization",pct(a.util)],
    ["Bench (FTE)",a.bench],["Active projects",a.active],["Delayed projects",a.delayed],
    ["Budget variance",pct(a.bvar)],["CSAT",a.csat.toFixed(2)+" / 5"]
  ];
  const projectRows=[["Project","ID","Portfolio","Customer","PM","Health","SPI","CPI","Revenue","Cost"]].concat(
    a.P.map(p=>[p.name,p.id,p.portfolio,p.customer,p.pm,p.health,p.spi.toFixed(2),p.cpi.toFixed(2),cr(p.revenue),cr(p.cost)])
  );
  return {a,title,headerName,fname:headerName,kpiRows,projectRows,charts:collectDashboardCharts()};
}
function htmlTable(rows){
  return "<table>"+rows.map((r,i)=>"<tr>"+r.map(c=> (i===0?"<th>":"<td>")+esc(c)+(i===0?"</th>":"</td>")).join("")+"</tr>").join("")+"</table>";
}
function collectDashboardCssText(){
  const wanted=["styles.css","cxo-pva.css"];
  let css="";
  for(const sheet of document.styleSheets){
    const href=((sheet.href||"").split("?")[0]||"");
    if(!wanted.some(w=>href.endsWith("/"+w)||href.endsWith(w))) continue;
    try{ css+="\n"+[...sheet.cssRules].map(r=>r.cssText).join("\n"); }catch(err){}
  }
  return css;
}
function loadDashboardCss(){
  const css=collectDashboardCssText();
  if(css && css.length>200) return Promise.resolve(css);
  return Promise.all(["css/styles.css","css/cxo-pva.css"].map(u=>
    fetch(u).then(r=>r.ok?r.text():"").catch(()=>"")
  )).then(parts=>parts.join("\n"));
}
function cloneDashboardMarkup(){
  const wrap=document.getElementById("AnalyticsWrapper")||document.querySelector(".app");
  if(!wrap) return "";
  const clone=wrap.cloneNode(true);
  if(wrap.id==="AnalyticsWrapper"){
    clone.id="AnalyticsWrapper";
    clone.removeAttribute("style");
    clone.style.display="block";
  }
  const srcCanvas=[...wrap.querySelectorAll("canvas")];
  const dstCanvas=[...clone.querySelectorAll("canvas")];
  srcCanvas.forEach((cv,i)=>{
    const dst=dstCanvas[i]; if(!dst) return;
    let src="";
    try{
      const ch=state.charts[cv.id];
      src=ch?chartPNG(ch):cv.toDataURL("image/png");
    }catch(err){}
    if(!src){ dst.remove(); return; }
    const img=document.createElement("img");
    const titleEl=cv.closest(".widget") && cv.closest(".widget").querySelector(".w-title");
    img.src=src;
    img.alt=titleEl?titleEl.textContent:"Chart";
    img.style.width="100%";
    img.style.height="100%";
    img.style.objectFit="contain";
    img.style.display="block";
    dst.parentNode.replaceChild(img,dst);
  });
  clone.querySelectorAll("script").forEach(n=>n.remove());
  clone.querySelectorAll("[onclick]").forEach(n=>n.removeAttribute("onclick"));
  clone.querySelectorAll("button").forEach(n=>{ n.setAttribute("type","button"); n.disabled=true; });
  return clone.outerHTML;
}
function snapshotHTML(cssText){
  const headerName=pageHeaderFileName();
  const markup=cloneDashboardMarkup();
  const extra="\n*{box-sizing:border-box}\nbody.export-snapshot{margin:0;background:#fff;overflow:auto}"
    +"\nbody.export-snapshot .bgwhite,#AnalyticsWrapper{display:block!important}"
    +"\nbody.export-snapshot button{cursor:default}"
    +"\nbody.export-snapshot .chartbox img{width:100%;height:100%;object-fit:contain;display:block}"
    +"\nbody.export-snapshot .preloader,body.export-snapshot .loader-overlay{display:none!important}";
  return "<!DOCTYPE html><html lang=\"en\" data-theme=\"light\"><head><meta charset=\"utf-8\">"
    +"<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
    +"<title>"+esc(headerName)+"</title>"
    +"<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css\">"
    +"<style>"+(cssText||"")+extra+"</style></head>"
    +"<body class=\"analytics-pva export-snapshot\" data-page=\""+esc(state.page)+"\">"
    +(markup||"<p>Dashboard snapshot unavailable.</p>")
    +"</body></html>";
}
function dataUrlToU8(dataUrl){
  const b64=(dataUrl.split(",")[1]||"");
  const bin=atob(b64);
  const u=new Uint8Array(bin.length);
  for(let i=0;i<bin.length;i++) u[i]=bin.charCodeAt(i);
  return u;
}
function crc32Bytes(u8){
  let c=0xFFFFFFFF;
  for(let i=0;i<u8.length;i++){
    c^=u8[i];
    for(let k=0;k<8;k++) c=(c&1)?(0xEDB88320^(c>>>1)):(c>>>1);
  }
  return (c^0xFFFFFFFF)>>>0;
}
function zipStore(files){
  const enc=new TextEncoder();
  const dvSet=(n,fn)=>{const b=new ArrayBuffer(n),v=new DataView(b);fn(v);return new Uint8Array(b)};
  const u16=n=>dvSet(2,v=>v.setUint16(0,n,true));
  const u32=n=>dvSet(4,v=>v.setUint32(0,n,true));
  const concat=parts=>{const len=parts.reduce((a,p)=>a+p.length,0);const o=new Uint8Array(len);let p=0;parts.forEach(x=>{o.set(x,p);p+=x.length});return o};
  const locals=[],centrals=[]; let offset=0;
  files.forEach(f=>{
    const name=enc.encode(f.name.replace(/\\/g,"/"));
    const data=f.data;
    const crc=crc32Bytes(data);
    const local=concat([u32(0x04034b50),u16(20),u16(0),u16(0),u16(0),u16(0),u32(crc),u32(data.length),u32(data.length),u16(name.length),u16(0),name,data]);
    const central=concat([u32(0x02014b50),u16(20),u16(20),u16(0),u16(0),u16(0),u16(0),u32(crc),u32(data.length),u32(data.length),u16(name.length),u16(0),u16(0),u16(0),u16(0),u32(0),u32(offset),name]);
    locals.push(local); centrals.push(central); offset+=local.length;
  });
  const centralDir=concat(centrals);
  const eocd=concat([u32(0x06054b50),u16(0),u16(0),u16(files.length),u16(files.length),u32(centralDir.length),u32(offset),u16(0)]);
  return new Blob([concat(locals.concat([centralDir,eocd]))],{type:"application/vnd.openxmlformats-officedocument.presentationml.presentation"});
}
function xmlEsc(s){return String(s).replace(/[&<>"']/g,c=>({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&apos;"}[c]));}
function renderExportSlideCanvas(payload){
  const w=1920,h=1080,c=document.createElement("canvas");
  c.width=w;c.height=h;
  const ctx=c.getContext("2d");
  ctx.fillStyle="#ffffff"; ctx.fillRect(0,0,w,h);
  ctx.fillStyle="#1e40af"; ctx.fillRect(0,0,w,88);
  ctx.fillStyle="#ffffff"; ctx.font="bold 32px Segoe UI, Arial";
  ctx.fillText(payload.title,36,56);
  ctx.font="16px Segoe UI, Arial";
  ctx.fillText((state.date.range||state.date.label)+"  ·  "+new Date().toLocaleDateString(),36,78);
  const kpis=payload.kpiRows.slice(1);
  const cols=4, cardW=450, cardH=78, gx=36, gy=112;
  kpis.forEach((row,i)=>{
    const x=gx+(i%cols)*(cardW+12), y=gy+Math.floor(i/cols)*(cardH+10);
    ctx.fillStyle="#f8fafc"; ctx.fillRect(x,y,cardW,cardH);
    ctx.strokeStyle="#e5e7eb"; ctx.strokeRect(x+.5,y+.5,cardW-1,cardH-1);
    ctx.fillStyle="#6b7280"; ctx.font="13px Segoe UI, Arial"; ctx.fillText(String(row[0]),x+16,y+28);
    ctx.fillStyle="#1e40af"; ctx.font="bold 26px Segoe UI, Arial"; ctx.fillText(String(row[1]),x+16,y+60);
  });
  return c;
}
function buildPptxBlob(pngU8,title){
  const xml=s=>new TextEncoder().encode(s);
  const files=[
    {name:"[Content_Types].xml",data:xml('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      +'<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">'
      +'<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>'
      +'<Default Extension="xml" ContentType="application/xml"/>'
      +'<Default Extension="png" ContentType="image/png"/>'
      +'<Override PartName="/ppt/presentation.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml"/>'
      +'<Override PartName="/ppt/slides/slide1.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.slide+xml"/>'
      +'<Override PartName="/ppt/slideLayouts/slideLayout1.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml"/>'
      +'<Override PartName="/ppt/slideMasters/slideMaster1.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml"/>'
      +'<Override PartName="/ppt/theme/theme1.xml" ContentType="application/vnd.openxmlformats-officedocument.theme+xml"/>'
      +'<Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>'
      +'<Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>'
      +'</Types>')},
    {name:"_rels/.rels",data:xml('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      +'<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
      +'<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="ppt/presentation.xml"/>'
      +'<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>'
      +'<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/>'
      +'</Relationships>')},
    {name:"docProps/core.xml",data:xml('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      +'<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'
      +'<dc:title>'+xmlEsc(title)+'</dc:title><dc:creator>Whizible</dc:creator></cp:coreProperties>')},
    {name:"docProps/app.xml",data:xml('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      +'<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties"><Application>Whizible</Application><Slides>1</Slides></Properties>')},
    {name:"ppt/presentation.xml",data:xml('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      +'<p:presentation xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main">'
      +'<p:sldMasterIdLst><p:sldMasterId id="2147483648" r:id="rId2"/></p:sldMasterIdLst>'
      +'<p:sldIdLst><p:sldId id="256" r:id="rId1"/></p:sldIdLst>'
      +'<p:sldSz cx="12192000" cy="6858000"/><p:notesSz cx="6858000" cy="9144000"/></p:presentation>')},
    {name:"ppt/_rels/presentation.xml.rels",data:xml('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      +'<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
      +'<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide" Target="slides/slide1.xml"/>'
      +'<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster" Target="slideMasters/slideMaster1.xml"/>'
      +'</Relationships>')},
    {name:"ppt/slides/slide1.xml",data:xml('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      +'<p:sld xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main"><p:cSld><p:spTree>'
      +'<p:nvGrpSpPr><p:cNvPr id="1" name=""/><p:cNvGrpSpPr/><p:nvPr/></p:nvGrpSpPr>'
      +'<p:grpSpPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="0" cy="0"/><a:chOff x="0" y="0"/><a:chExt cx="0" cy="0"/></a:xfrm></p:grpSpPr>'
      +'<p:pic><p:nvPicPr><p:cNvPr id="2" name="Dashboard"/><p:cNvPicPr><a:picLocks noChangeAspect="1"/></p:cNvPicPr><p:nvPr/></p:nvPicPr>'
      +'<p:blipFill><a:blip r:embed="rId2"/><a:stretch><a:fillRect/></a:stretch></p:blipFill>'
      +'<p:spPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="12192000" cy="6858000"/></a:xfrm><a:prstGeom prst="rect"><a:avLst/></a:prstGeom></p:spPr></p:pic>'
      +'</p:spTree></p:cSld><p:clrMapOvr><a:masterClrMapping/></p:clrMapOvr></p:sld>')},
    {name:"ppt/slides/_rels/slide1.xml.rels",data:xml('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      +'<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
      +'<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout" Target="../slideLayouts/slideLayout1.xml"/>'
      +'<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="../media/image1.png"/>'
      +'</Relationships>')},
    {name:"ppt/media/image1.png",data:pngU8},
    {name:"ppt/slideLayouts/slideLayout1.xml",data:xml('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      +'<p:sldLayout xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main" type="blank" preserve="1"><p:cSld name="Blank"><p:spTree>'
      +'<p:nvGrpSpPr><p:cNvPr id="1" name=""/><p:cNvGrpSpPr/><p:nvPr/></p:nvGrpSpPr>'
      +'<p:grpSpPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="0" cy="0"/><a:chOff x="0" y="0"/><a:chExt cx="0" cy="0"/></a:xfrm></p:grpSpPr>'
      +'</p:spTree></p:cSld><p:clrMapOvr><a:masterClrMapping/></p:clrMapOvr></p:sldLayout>')},
    {name:"ppt/slideLayouts/_rels/slideLayout1.xml.rels",data:xml('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      +'<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
      +'<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster" Target="../slideMasters/slideMaster1.xml"/>'
      +'</Relationships>')},
    {name:"ppt/slideMasters/slideMaster1.xml",data:xml('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      +'<p:sldMaster xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main"><p:cSld><p:bg><p:bgRef idx="1001"><a:schemeClr val="bg1"/></p:bgRef></p:bg><p:spTree>'
      +'<p:nvGrpSpPr><p:cNvPr id="1" name=""/><p:cNvGrpSpPr/><p:nvPr/></p:nvGrpSpPr>'
      +'<p:grpSpPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="0" cy="0"/><a:chOff x="0" y="0"/><a:chExt cx="0" cy="0"/></a:xfrm></p:grpSpPr>'
      +'</p:spTree></p:cSld>'
      +'<p:clrMap bg1="lt1" tx1="dk1" bg2="lt2" tx2="dk2" accent1="accent1" accent2="accent2" accent3="accent3" accent4="accent4" accent5="accent5" accent6="accent6" hlink="hlink" folHlink="folHlink"/>'
      +'<p:sldLayoutIdLst><p:sldLayoutId id="2147483649" r:id="rId1"/></p:sldLayoutIdLst></p:sldMaster>')},
    {name:"ppt/slideMasters/_rels/slideMaster1.xml.rels",data:xml('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      +'<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
      +'<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout" Target="../slideLayouts/slideLayout1.xml"/>'
      +'<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="../theme/theme1.xml"/>'
      +'</Relationships>')},
    {name:"ppt/theme/theme1.xml",data:xml('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      +'<a:theme xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" name="Whizible"><a:themeElements>'
      +'<a:clrScheme name="Whizible"><a:dk1><a:sysClr val="windowText" lastClr="000000"/></a:dk1><a:lt1><a:sysClr val="window" lastClr="FFFFFF"/></a:lt1>'
      +'<a:dk2><a:srgbClr val="1E40AF"/></a:dk2><a:lt2><a:srgbClr val="F3F4F6"/></a:lt2>'
      +'<a:accent1><a:srgbClr val="1359A6"/></a:accent1><a:accent2><a:srgbClr val="54B054"/></a:accent2><a:accent3><a:srgbClr val="EAA300"/></a:accent3>'
      +'<a:accent4><a:srgbClr val="9373C0"/></a:accent4><a:accent5><a:srgbClr val="479EF5"/></a:accent5><a:accent6><a:srgbClr val="DC626D"/></a:accent6>'
      +'<a:hlink><a:srgbClr val="1359A6"/></a:hlink><a:folHlink><a:srgbClr val="1E40AF"/></a:folHlink></a:clrScheme>'
      +'<a:fontScheme name="Whizible"><a:majorFont><a:latin typeface="Calibri"/><a:ea typeface=""/><a:cs typeface=""/></a:majorFont>'
      +'<a:minorFont><a:latin typeface="Calibri"/><a:ea typeface=""/><a:cs typeface=""/></a:minorFont></a:fontScheme>'
      +'<a:fmtScheme name="Whizible"><a:fillStyleLst><a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:solidFill><a:schemeClr val="phClr"/></a:solidFill></a:fillStyleLst>'
      +'<a:lnStyleLst><a:ln w="12700" cap="flat" cmpd="sng" algn="ctr"><a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:prstDash val="solid"/></a:ln>'
      +'<a:ln w="19050" cap="flat" cmpd="sng" algn="ctr"><a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:prstDash val="solid"/></a:ln>'
      +'<a:ln w="25400" cap="flat" cmpd="sng" algn="ctr"><a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:prstDash val="solid"/></a:ln></a:lnStyleLst>'
      +'<a:effectStyleLst><a:effectStyle><a:effectLst/></a:effectStyle><a:effectStyle><a:effectLst/></a:effectStyle><a:effectStyle><a:effectLst/></a:effectStyle></a:effectStyleLst>'
      +'<a:bgFillStyleLst><a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:solidFill><a:schemeClr val="phClr"/></a:solidFill></a:bgFillStyleLst>'
      +'</a:fmtScheme></a:themeElements></a:theme>')}
  ];
  return zipStore(files);
}
function exportDashboard(fmt){
  closeMenus();
  try{
    const payload=dashboardExportPayload();
    if(fmt==="csv"){
      const csv="\ufeff"+payload.kpiRows.map(r=>r.map(csvCell).join(",")).join("\n")
        +"\n\n"+payload.projectRows.map(r=>r.map(csvCell).join(",")).join("\n");
      downloadBlob(csv,payload.fname+".csv","text/csv;charset=utf-8");
      toast("Dashboard downloaded as CSV");
      return;
    }
    if(fmt==="excel"){
      const html="\ufeff<html xmlns:o=\"urn:schemas-microsoft-com:office:office\" xmlns:x=\"urn:schemas-microsoft-com:office:excel\"><head><meta charset=\"utf-8\"></head><body>"
        +"<h3>"+esc(payload.title)+"</h3><h4>KPIs</h4>"+htmlTable(payload.kpiRows)
        +"<h4>Projects</h4>"+htmlTable(payload.projectRows)+"</body></html>";
      downloadBlob(html,payload.fname+".xls","application/vnd.ms-excel");
      toast("Dashboard exported to Excel");
      return;
    }
    if(fmt==="html"){
      const htmlName=htmlExportFileName();
      loadDashboardCss().then(css=>{
        downloadBlob(snapshotHTML(css),htmlName,"text/html;charset=utf-8");
        toast("Downloaded "+htmlName);
      }).catch(err=>{
        console.error(err);
        toast("HTML export failed — please try again");
      });
      return;
    }
    if(fmt==="ppt"){
      const canvas=renderExportSlideCanvas(payload);
      const waitImages=payload.charts.slice(0,2).map(ch=>new Promise(res=>{
        const img=new Image();
        img.onload=()=>res(img); img.onerror=()=>res(null); img.src=ch.src;
      }));
      Promise.all(waitImages).then(imgs=>{
        const ctx=canvas.getContext("2d");
        const kpis=payload.kpiRows.slice(1);
        const cols=4, cardH=78, gx=36, gy=112;
        const kpiRowsN=Math.ceil(kpis.length/cols);
        let y=gy+kpiRowsN*(cardH+10)+16;
        const availH=1080-y-36, gap=16, cw=Math.floor((1920-gx*2-(imgs.length-1)*gap)/Math.max(imgs.length,1));
        imgs.forEach((img,i)=>{
          if(!img) return;
          const x=gx+i*(cw+gap);
          ctx.fillStyle="#111827"; ctx.font="bold 16px Segoe UI, Arial";
          ctx.fillText(payload.charts[i].title,x,y+14);
          const maxW=cw, maxH=availH-24;
          const scale=Math.min(maxW/img.width, maxH/img.height);
          const dw=img.width*scale, dh=img.height*scale;
          ctx.drawImage(img,x,y+24,dw,dh);
        });
        const pngU8=dataUrlToU8(canvas.toDataURL("image/png"));
        downloadBlob(buildPptxBlob(pngU8,payload.title),payload.fname+".pptx","application/vnd.openxmlformats-officedocument.presentationml.presentation");
        toast("Dashboard exported to Microsoft PowerPoint");
      }).catch(()=>{
        const pngU8=dataUrlToU8(canvas.toDataURL("image/png"));
        downloadBlob(buildPptxBlob(pngU8,payload.title),payload.fname+".pptx","application/vnd.openxmlformats-officedocument.presentationml.presentation");
        toast("Dashboard exported to Microsoft PowerPoint");
      });
    }
  }catch(err){
    console.error(err);
    toast("Export failed — please try again");
  }
}
function widgetTableRows(id){
  const el=document.getElementById(id);
  const t=el && el.querySelector("table");
  if(!t) return null;
  return [...t.querySelectorAll("tr")].map(tr=>[...tr.children].map(td=>td.innerText.replace(/\s+/g," ").trim()));
}
function exportWidgetCSV(id){
  const rows=widgetTableRows(id);
  if(!rows || !rows.length){ exportDashboard("csv"); return; }
  downloadBlob("\ufeff"+rows.map(r=>r.map(csvCell).join(",")).join("\n"),"whizible-export.csv","text/csv;charset=utf-8");
  toast("CSV downloaded · whizible-export.csv");
}
function exportWidgetExcel(id){
  const rows=widgetTableRows(id);
  if(!rows || !rows.length){ exportDashboard("excel"); return; }
  downloadBlob("\ufeff<html><head><meta charset='utf-8'></head><body>"+htmlTable(rows)+"</body></html>","whizible-export.xls","application/vnd.ms-excel");
  toast("Exported to Excel");
}
function exportDrillAs(fmt){
  let rows=null;
  if(state.lastDrillRows && state.lastDrillRows.length){
    rows=state.lastDrillRows.map(r=>r.map(c=>String(c).replace(/<[^>]*>/g," ").replace(/\s+/g," ").trim()));
  }
  if((!rows || !rows.length) && $("#mBody")){
    const t=$("#mBody table");
    if(t) rows=[...t.querySelectorAll("tr")].map(tr=>[...tr.children].map(td=>td.innerText.replace(/\s+/g," ").trim()));
  }
  if(!rows || !rows.length){
    toast("No drill-down rows to export");
    return;
  }
  const fname="whizible-drilldown";
  if(fmt==="csv"){
    downloadBlob("\ufeff"+rows.map(r=>r.map(csvCell).join(",")).join("\n"),fname+".csv","text/csv;charset=utf-8");
    toast("CSV downloaded");
    return;
  }
  if(fmt==="excel"){
    downloadBlob("\ufeff<html><head><meta charset='utf-8'></head><body><h3>Drill-down</h3>"+htmlTable(rows)+"</body></html>",fname+".xls","application/vnd.ms-excel");
    toast("Exported to Excel");
    return;
  }
  if(fmt==="html"){
    downloadBlob("<!DOCTYPE html><html><head><meta charset='utf-8'><title>Drill-down</title></head><body><h3>Drill-down</h3>"+htmlTable(rows)+"</body></html>",fname+".html","text/html;charset=utf-8");
    toast("HTML downloaded");
    return;
  }
  toast("No drill-down rows to export");
}
function placeMenu(m,e){
  const r=(e.currentTarget||(e.target && e.target.closest && e.target.closest("button"))||e.target).getBoundingClientRect();
  m.style.position="fixed";
  m.style.zIndex="400";
  const mw=m.offsetWidth||220;
  const mh=m.offsetHeight||48;
  let left=r.right-mw;
  if(left<8) left=8;
  if(left+mw>innerWidth-8) left=Math.max(8, innerWidth-mw-8);
  let top=r.bottom+6;
  if(top+mh>innerHeight-8) top=Math.max(8, r.top-mh-6);
  m.style.top=top+"px";
  m.style.left=left+"px";
}
function runExport(fmt,target){
  closeMenus();
  if(fmt==="email"){
    toast("Emailed to your default report group (4 recipients)");
    return;
  }
  if(target==="drill"){ exportDrillAs(fmt); return; }
  if(target && target!=="dashboard"){
    if(fmt==="csv"){ exportWidgetCSV(target); return; }
    if(fmt==="excel"){ exportWidgetExcel(target); return; }
  }
  exportDashboard(fmt);
}
function excelIconHtml(){
  return `<span class="xls-ico" aria-hidden="true"><svg viewBox="0 0 32 32" width="18" height="18" focusable="false"><rect x="10" y="3" width="19" height="26" rx="3" fill="#fff" stroke="#c5c9ce"/><rect x="15.2" y="18.2" width="2.3" height="6.3" rx="0.4" fill="#4a86e8"/><rect x="18.4" y="14.4" width="2.3" height="10.1" rx="0.4" fill="#ed7d31"/><rect x="21.6" y="11.2" width="2.3" height="13.3" rx="0.4" fill="#70ad47"/><rect x="24.8" y="8.4" width="2.3" height="16.1" rx="0.4" fill="#ffc000"/><path d="M3.5 8.5h13.2v15H3.5z" fill="#185c37"/><path d="M7.1 11.6l2.5 4 2.5-4h2.2l-3.6 5.4 3.7 5.6h-2.3l-2.5-4.1-2.5 4.1H5l3.7-5.6-3.6-5.4h2z" fill="#fff"/></svg></span>`;
}
function showExportMenu(e,target){
  e.stopPropagation(); closeMenus();
  const t=target==null?"dashboard":String(target);
  const m=document.createElement("div");m.className="menu menu-widget-export";
  m.innerHTML=`<div class="mhd">Export to</div>
    <button type="button" class="menu-excel-btn" onclick="event.stopPropagation();runExport('excel','${t}')">${excelIconHtml()}<span>Microsoft Excel</span></button>`;
  m.onclick=ev=>ev.stopPropagation();
  document.body.appendChild(m);
  placeMenu(m,e);
  setTimeout(()=>document.addEventListener("click",closeMenus,{once:true}));
}
function shareMenu(e){
  e.stopPropagation(); closeMenus();
  const m=document.createElement("div");m.className="menu menu-share";
  m.innerHTML=`<div class="mhd">Export dashboard to</div>
    <button type="button" onclick="event.stopPropagation();exportDashboard('ppt')">📽 Microsoft PowerPoint</button>
    <button type="button" onclick="event.stopPropagation();exportDashboard('html')">🌐 HTML report</button>
    <button type="button" class="menu-excel-btn" onclick="event.stopPropagation();exportDashboard('excel')">${excelIconHtml()}<span>Excel</span></button>
    <button type="button" onclick="event.stopPropagation();exportDashboard('csv')">⬇ CSV</button>
    <button type="button" onclick="event.stopPropagation();closeMenus();window.print()">🖨 Print</button>
    <div class="mhd">Share</div>
    <button type="button" onclick="event.stopPropagation();showComingSoon('link')">🔗 Copy secure link</button>
    <button type="button" onclick="event.stopPropagation();showComingSoon('teams')">💬 Share to Teams</button>
    <button type="button" onclick="event.stopPropagation();runExport('email','dashboard')">✉ Email report</button>
    <div class="mhd">Schedule</div>
    <button type="button" onclick="event.stopPropagation();closeMenus();toast('Scheduled weekly: every Monday 8:00 AM IST')">⏰ Schedule weekly</button>
    <button type="button" onclick="event.stopPropagation();closeMenus();toast('Scheduled fortnightly: alternate Mondays 8:00 AM IST')">⏰ Schedule fortnightly</button>
    <button type="button" onclick="event.stopPropagation();closeMenus();toast('Scheduled monthly: 1st working day, 8:00 AM IST')">⏰ Schedule monthly</button>
    <button type="button" onclick="event.stopPropagation();closeMenus();toast('Scheduled quarterly: with QBR pack, first Monday of quarter')">⏰ Schedule quarterly</button>
    <div class="mhd">Views</div>
    <button type="button" onclick="event.stopPropagation();closeMenus();execOpenSaveModal()">☆ Save this view</button>
    <button type="button" onclick="event.stopPropagation();closeMenus();execOpenMyViews()">☆ My saved views</button>`;
  m.onclick=ev=>ev.stopPropagation();
  document.body.appendChild(m);
  placeMenu(m,e);
  setTimeout(()=>document.addEventListener("click",closeMenus,{once:true}));
}
function exportMenu(e,id){ showExportMenu(e,id||"dashboard"); }
function comingSoonEsc(e){ if(e.key==="Escape") closeComingSoon(); }
function closeComingSoon(){
  document.removeEventListener("keydown", comingSoonEsc);
  const el=document.getElementById("comingSoonModal");
  if(el) el.remove();
}
function showComingSoon(kind){
  closeMenus();
  closeComingSoon();
  const isTeams=kind==="teams";
  const wrap=document.createElement("div");
  wrap.id="comingSoonModal";
  wrap.className="coming-soon-wrap";
  wrap.setAttribute("role","dialog");
  wrap.setAttribute("aria-modal","true");
  wrap.setAttribute("aria-labelledby","comingSoonTitle");
  wrap.innerHTML=`<div class="coming-soon-card">
    <button type="button" class="coming-soon-close" onclick="closeComingSoon()" aria-label="Close" title="Close"><i class="fas fa-times"></i></button>
    <div class="coming-soon-icon" aria-hidden="true">
      <span class="coming-soon-orb"></span>
      <i class="fas fa-rocket"></i>
      <span class="coming-soon-spark coming-soon-spark-1">✦</span>
      <span class="coming-soon-spark coming-soon-spark-2">✧</span>
      <span class="coming-soon-spark coming-soon-spark-3">✦</span>
    </div>
    <div class="coming-soon-badge">Coming Soon</div>
    <h3 id="comingSoonTitle">${isTeams?"Share to Teams":"Copy secure link"}</h3>
  </div>`;
  wrap.addEventListener("click",ev=>{ if(ev.target===wrap) closeComingSoon(); });
  document.body.appendChild(wrap);
  document.addEventListener("keydown", comingSoonEsc);
}
function exportDrillMenu(e){ showExportMenu(e,"drill"); }
function copilotBtnIcon(){
  return `<img class="copilot-btn-icon" src="../../../Whizible2.0-new/dist/img/Whizkidlogo.png" alt="">`;
}
function exportShareBtn(){
  return `<button class="ghostbtn" type="button" title="Export / Share" onclick="shareMenu(event)">${widgetToolIcon("fa-share-alt","⇪")} Export / Share</button>`;
}
function closeMenus(){
  $$(".menu,.pop").forEach(x=>{
    if(x._onDocClose) document.removeEventListener("mousedown", x._onDocClose, true);
    x.remove();
  });
}
function downloadCSV(text,name){
  downloadBlob(text,name,"text/csv;charset=utf-8");
  toast("CSV downloaded · "+name);
}
function toast(msg){
  const t=document.createElement("div");t.className="toast";t.innerHTML=`<span class="tk">✓</span>${esc(msg)}`;
  $("#toasts").appendChild(t);setTimeout(()=>t.remove(),3400);
}

/* =====================================================================
   GLOBAL FILTER BAR + GA-STYLE DATE PICKER
===================================================================== */
function renderChips(){
  $("#chips").innerHTML=Object.keys(FILTER_DEFS).map(k=>{
    const n=state.filters[k].length;
    return `<button type="button" class="chipbtn ${n?"on":""}" data-chip="${k}">${k}${n?` <span class="cnt">${n}</span>`:" ▾"}</button>`;
  }).join("");
  $$("[data-chip]").forEach(b=>b.onclick=e=>openFilterPop(e,b.dataset.chip));
}
function openFilterPop(e,key){
  e.stopPropagation();closeMenus();
  const pop=document.createElement("div");pop.className="pop";
  const apiOpts=TopFilter.options[key];
  const useIds=Array.isArray(apiOpts) && apiOpts.length>0;
  const opts=useIds?apiOpts:(FILTER_DEFS[key]||[]).map(name=>({id:name, name:name}));
  pop.innerHTML=`<input class="search" placeholder="Search ${key.toLowerCase()}…">
    <div class="pop-hd">${key} · multi-select</div>`+
    opts.map(o=>{
      const sel=useIds?isTopFilterSelected(key,o.id):(state.filters[key]||[]).includes(o.name);
      return `<button type="button" class="pop-item ${sel?"sel":""}" data-id="${esc(o.id)}" data-v="${esc(o.name)}"><span class="box">${sel?"✓":""}</span>${esc(o.name)}</button>`;
    }).join("");
  document.body.appendChild(pop);
  const r=e.target.getBoundingClientRect();
  pop.style.top=(r.bottom+6+window.scrollY)+"px";pop.style.left=Math.min(r.left,innerWidth-250)+"px";
  pop.onclick=ev=>ev.stopPropagation();
  pop.querySelector(".search").oninput=ev=>{
    const q=ev.target.value.toLowerCase();
    pop.querySelectorAll(".pop-item").forEach(it=>it.style.display=(it.dataset.v||"").toLowerCase().includes(q)?"":"none");
  };
  pop.querySelectorAll(".pop-item").forEach(it=>it.onclick=()=>{
    if(useIds){
      toggleTopFilterSelection(key, {id:it.dataset.id, name:it.dataset.v});
      const sel=isTopFilterSelected(key, it.dataset.id);
      it.classList.toggle("sel", sel);
      it.querySelector(".box").textContent=sel?"✓":"";
    }else{
      const v=it.dataset.v,arr=state.filters[key]||(state.filters[key]=[]);
    arr.includes(v)?arr.splice(arr.indexOf(v),1):arr.push(v);
    it.classList.toggle("sel");it.querySelector(".box").textContent=arr.includes(v)?"✓":"";
    }
    if(isTimesheetPage()) resetTimesheetDrill();
    const afterChip=function(){
      renderChips();renderPage();persistState();
    };
    if(isTimesheetPage() && (key==="Portfolio"||key==="Customer")){
      if(key==="Portfolio" && typeof onPortfolioFilterChanged==="function"){
        onPortfolioFilterChanged(true);
        return;
      }
      reloadTimesheetProjectManagers(afterChip);
      return;
    }
    if(key==="Portfolio" && typeof onPortfolioFilterChanged==="function"){
      onPortfolioFilterChanged(true);
      return;
    }
    afterChip();
  });
  setTimeout(()=>document.addEventListener("click",closeMenus,{once:true}));
}
/* ---------- Google Analytics style date picker (real calendar dates) ---------- */
const getToday=()=>{ const n=new Date(); return new Date(n.getFullYear(),n.getMonth(),n.getDate()); };
const addD=(d,n)=>{const x=new Date(d);x.setDate(x.getDate()+n);return x;};
const sow=d=>{const x=new Date(d);x.setDate(x.getDate()-x.getDay());return x;}; // Sunday
const startOfMonth=d=>new Date(d.getFullYear(),d.getMonth(),1);
const endOfMonth=d=>new Date(d.getFullYear(),d.getMonth()+1,0);
const fmtD=d=>d.toLocaleDateString("en-US",{month:"short",day:"numeric",year:"numeric"});
const sameD=(a,b)=>a&&b&&a.toDateString()===b.toDateString();
const rangeLbl=(a,b)=>sameD(a,b)?fmtD(a):a.toLocaleDateString("en-US",{month:"short",day:"numeric"})+" - "+fmtD(b);
const parseSavedDate=v=>{ if(!v) return null; const d=new Date(v); return isNaN(d.getTime())?null:d; };
const cloneDate=d=>{
  if(!d) return null;
  const x=d instanceof Date ? d : parseSavedDate(d);
  return x && !isNaN(x.getTime()) ? new Date(x.getFullYear(), x.getMonth(), x.getDate()) : null;
};
const dayCount=(s,e)=>Math.round((e-s)/864e5)+1;
function addYearsKeepDate(d, years){
  const nd=new Date(d.getFullYear()+years, d.getMonth(), d.getDate());
  if(nd.getMonth()!==d.getMonth()) return new Date(d.getFullYear()+years, d.getMonth()+1, 0);
  return nd;
}
const GA_COMPARE_MODES=[
  {id:"prev_dow", label:"Previous period"},
  {id:"prev", label:"Previous period"},
  {id:"prev_year", label:"Previous year"},
  {id:"prev_year_dow", label:"Previous year"},
  {id:"custom", label:"Custom Comparison"}
];
function compareModeMeta(id){
  return GA_COMPARE_MODES.find(m=>m.id===id) || GA_COMPARE_MODES[0];
}
function compareShortLabel(id){
  const map={
    prev_dow:"prev period",
    prev:"prev period",
    prev_year:"prev year",
    prev_year_dow:"prev year",
    custom:"custom period"
  };
  return map[id] || "prev period";
}
function compareTagText(id){
  const map={
    prev_dow:"Vs Previous Period",
    prev:"Vs Previous Period",
    prev_year:"Vs Previous Year",
    prev_year_dow:"Vs Previous Year",
    custom:"vs custom period"
  };
  return map[id] || "Vs Previous Period";
  /* Modify By Madhuri.K On 28-09-2026 */
}
function formatCompareTagName(name){
  return String(name||"")
    .replace(/^vs\s+/i,"")
    .replace(/\s*\(match day of week\)\s*/ig,"")
    .replace(/\s{2,}/g," ")
    .trim();
}
function titleCaseWords(s){
  return String(s||"").replace(/\w\S*/g, function(w){
    return w.charAt(0).toUpperCase()+w.slice(1).toLowerCase();
  });
}
window.formatCompareTagName=formatCompareTagName;
window.titleCaseWords=titleCaseWords;
window.compareTagText=compareTagText;
/* Same DateFilter calendar as PM_AnalyticsCXO_Dashboard.aspx — API-backed with local fallback. */
var DEFAULT_DATE_OPTION=(typeof window!=="undefined" && window.DEFAULT_DATE_OPTION)||"Current Quarter";
var DateFilter={
  dateOptions:[],
  comparisonOptions:[],
  filterOptionsLoaded:false,
  dateRangeCache:{},
  compareRangeCache:{},
  selectedFilterId:null,
  selectedFilterName:DEFAULT_DATE_OPTION,
  selectedComparisonId:null,
  selectedComparisonName:"",
  compare:false,
  startDate:null,
  endDate:null,
  previousStart:null,
  previousEnd:null,
  lastRange:null
};
function getDashboardId(){
  const id=(typeof window!=="undefined" && window.DASHBOARD_ID!=null)?window.DASHBOARD_ID:null;
  const n=Number(id);
  return isFinite(n)?n:0;
}
function getFilterApiBase(){
  const u=(typeof window!=="undefined" && window.strUrl)?String(window.strUrl):(typeof strUrl!=="undefined"?String(strUrl):"");
  return u.replace(/\/+$/,"");
}
function getFilterApiController(){
  if(typeof window!=="undefined" && window.FILTER_API_CONTROLLER)
    return String(window.FILTER_API_CONTROLLER).replace(/^\/+|\/+$/g,"");
  return "";
}
function canUseFilterApis(){
  return !!(getFilterApiBase() && getDashboardId() && getFilterApiController());
}
function getFilterField(row){
  if(!row) return undefined;
  for(let i=1;i<arguments.length;i++){
    const key=arguments[i];
    if(row[key]!=null && row[key]!=="") return row[key];
    const found=Object.keys(row).find(k=>String(k).toLowerCase()===String(key).toLowerCase());
    if(found!=null && row[found]!=null && row[found]!=="") return row[found];
  }
  return undefined;
}
function getApiRows(json, modelName){
  function walk(node, depth){
    if(node==null || depth>6) return [];
    if(Array.isArray(node)) return node;
    if(typeof node!=="object") return [];
    const names=modelName?[modelName, modelName.charAt(0).toLowerCase()+modelName.slice(1)]:[];
    for(let i=0;i<names.length;i++){
      const rows=getFilterField(node, names[i]);
      if(Array.isArray(rows)) return rows;
    }
    const nested=node.data!=null?node.data:node.Data;
    if(nested!=null && nested!==node){
      const rows=walk(nested, depth+1);
      if(rows.length) return rows;
    }
    for(const k in node){
      if(Object.prototype.hasOwnProperty.call(node,k) && Array.isArray(node[k])) return node[k];
    }
    return [];
  }
  return walk(json, 0);
}
function formatApiDate(d){
  if(!d) return "";
  const dt=d instanceof Date?d:parseFilterDate(d);
  if(!dt) return "";
  const m=dt.getMonth()+1, day=dt.getDate();
  return dt.getFullYear()+"-"+(m<10?"0":"")+m+"-"+(day<10?"0":"")+day;
}
function isComparisonRow(row){
  const v=getFilterField(row,"IsComparison");
  return v===true || v===1 || v==="1" || String(v).toLowerCase()==="true";
}
function toCxoFilterPayload(payload){
  const p=payload||{};
  const out={};
  const dash=p.DashboardID!=null?p.DashboardID:p.dashboardID;
  if(dash!=null) out.DashboardID=dash;
  if(p.Flag!=null || p.flag!=null) out.Flag=p.Flag!=null?p.Flag:p.flag;
  if(p.StartDate!=null || p.startDate!=null) out.StartDate=p.StartDate!=null?p.StartDate:p.startDate;
  if(p.EndDate!=null || p.endDate!=null) out.EndDate=p.EndDate!=null?p.EndDate:p.endDate;
  if(p.IsComparison!=null || p.isComparison!=null) out.IsComparison=p.IsComparison!=null?p.IsComparison:p.isComparison;
    /* Modify By Madhuri.K On 28-09-2026 */
  const uid=p.UserID!=null?p.UserID:p.userID;
  if(uid!=null && uid!=="") out.UserID=uid;
  const login=p.LoginType!=null?p.LoginType:p.loginType;
  if(login!=null && login!=="") out.LoginType=login;
  const roleId=p.RoleID!=null?p.RoleID:p.roleID;
  if(roleId!=null && roleId!=="") out.RoleID=roleId;
  const pf=p.PortfolioIDs!=null?p.PortfolioIDs:p.portfolioIDs;
  if(pf!=null) out.PortfolioIDs=pf;
  const cu=p.CustomerIDs!=null?p.CustomerIDs:p.customerIDs;
  if(cu!=null) out.CustomerIDs=cu;
  /* Save View / My Views / Delete — keep user-filter fields (do not strip). Madhuri.K GetDefaultOnly. */
  const sid=p.SessionEmployeeID!=null?p.SessionEmployeeID:p.sessionEmployeeID;
  if(sid!=null && sid!=="") out.SessionEmployeeID=String(sid);
  if(p.FilterName!=null) out.FilterName=p.FilterName;
  if(p.FilterJson!=null) out.FilterJson=p.FilterJson;
  if(p.IsDefaultFilter!=null) out.IsDefaultFilter=p.IsDefaultFilter;
  if(p.UserFilterID!=null || p.userFilterID!=null) out.UserFilterID=p.UserFilterID!=null?p.UserFilterID:p.userFilterID;
  if(p.GetDefaultOnly!=null || p.getDefaultOnly!=null) out.GetDefaultOnly=p.GetDefaultOnly!=null?p.GetDefaultOnly:p.getDefaultOnly;
  return Object.keys(out).length?out:p;
}
/* Prefer page callDashboardApi (CXO) — same auth as FlagWise; else filter API helper. */
function callUserFilterApi(actionName, body, onSuccess, onError){
  if(typeof window!=="undefined" && typeof window.callDashboardApi==="function"){
    window.callDashboardApi(actionName, body, onSuccess, onError);
    return;
  }
  if(typeof callFilterDashboardApi==="function" && canUseFilterApis()){
    callFilterDashboardApi(actionName, body, onSuccess, onError);
    return;
  }
  if(onError) onError(new Error("User filter API is not available"));
}
function callFilterDashboardApi(actionName, requestBody, onSuccess, onError){
  const base=getFilterApiBase();
  if(!base){
    if(onError) onError(new Error("Filter API base URL is not configured"));
    return;
  }
  const controller=getFilterApiController();
  const payload=controller==="PM_AnalyticsCXO_Dashboard"?toCxoFilterPayload(requestBody||{}):(requestBody||{});
  const bodyText=JSON.stringify(payload);
  const headers={
    "Content-Type":"application/json; charset=utf-8",
    "Authorization":"bearer "+(sessionStorage.getItem("access_token_W27_Dashboard")||"")
  };
  if(typeof encryptString==="function") headers.Params=encryptString(bodyText);
  fetch(encodeURI(base)+"/api/"+controller+"/"+actionName,{
    method:"POST",
    headers:headers,
    body:bodyText
  }).then(res=>{
    if(!res.ok) throw new Error(actionName+" failed: "+res.status);
    return res.json().catch(()=>({}));
  }).then(json=>{ if(onSuccess) onSuccess(json); })
    .catch(err=>{
      console.error(actionName, err);
      if(onError) onError(err);
    });
}
function parseFilterDate(value){
  if(!value) return null;
  if(value instanceof Date && !isNaN(value.getTime())) return new Date(value.getFullYear(),value.getMonth(),value.getDate());
  const m=String(value).match(/^(\d{4})-(\d{2})-(\d{2})/);
  if(m) return new Date(Number(m[1]),Number(m[2])-1,Number(m[3]));
  const d=new Date(value);
  if(!isNaN(d.getTime())) return new Date(d.getFullYear(),d.getMonth(),d.getDate());
  return cloneDate(value);
}
function findFilterOption(name,list){
  const n=String(name||"").toLowerCase();
  return (list||[]).find(row=>String(getFilterField(row,"FilterName")||"").toLowerCase()===n)||null;
}
function getDefaultDateOption(list){
  const rows=list||[];
  let found=rows.find(r=>String(getFilterField(r,"FilterName")||"").toLowerCase()===String(DEFAULT_DATE_OPTION).toLowerCase());
  if(found) return found;
  found=rows.find(r=>String(getFilterField(r,"FilterName")||"").toLowerCase()!=="custom");
  return found||rows[0]||null;
}
function isCustomComparisonFlag(name){
  const n=String(name||"").replace(/\s+/g,"").toLowerCase();
  return n==="customcomparison"||n==="custom";
}
function isCustomComparison(mode){ return isCustomComparisonFlag(mode); }
/* Added by Dipali V. on 01-10-2026 — CXO Custom / Previous period helpers (calendar + KPI bag). */
function isCustomPeriodFlag(name){
  return String(name||"").trim().toLowerCase()==="custom";
}
function isAlignedPreviousPeriodComparison(name){
  return String(name||"").trim().toLowerCase()==="previous period";
}
function computePreviousPeriodEqualLength(startDate, endDate){
  if(!startDate||!endDate) return {start:null, end:null};
  const s=new Date(startDate.getFullYear(), startDate.getMonth(), startDate.getDate());
  const e=new Date(endDate.getFullYear(), endDate.getMonth(), endDate.getDate());
  if(e<s) return {start:null, end:null};
  const days=dayCount(s, e);
  const prevEnd=new Date(s.getFullYear(), s.getMonth(), s.getDate()-1);
  const prevStart=new Date(prevEnd.getFullYear(), prevEnd.getMonth(), prevEnd.getDate()-(days-1));
  return {start:prevStart, end:prevEnd};
}
function applyPreviousDatesFromRangeRow(ds, row){
  if(!ds||!row) return false;
  const cs=parseFilterDate(getFilterField(row,"PreviousStartDate"));
  const ce=parseFilterDate(getFilterField(row,"PreviousEndDate"));
  if(!cs||!ce) return false;
  ds.cs=cs;
  ds.ce=ce;
  return true;
}
/* Custom Comparison: compare dates must be strictly before current Start Date. */
function isDayOnOrAfter(a, b){
  if(!a||!b) return false;
  return a.getFullYear()>b.getFullYear()
    || (a.getFullYear()===b.getFullYear() && a.getMonth()>b.getMonth())
    || (a.getFullYear()===b.getFullYear() && a.getMonth()===b.getMonth() && a.getDate()>=b.getDate());
}
function isDayBefore(a, b){
  return !!(a && b && !isDayOnOrAfter(a, b));
}
function isCustomComparePickActive(ds){
  return !!(ds && ds.cmp && ds.pickingCmp && isCustomComparisonFlag(ds.comparisonName));
}
function isCustomCompareDayDisabled(dt, ds){
  if(!isCustomComparePickActive(ds)) return false;
  if(!ds.s) return true;
  return isDayOnOrAfter(dt, ds.s);
}
function clampCustomCompareToBeforeStart(ds){
  if(!ds || !isCustomComparisonFlag(ds.comparisonName) || !ds.s) return;
  if(ds.cs && !isDayBefore(ds.cs, ds.s)){ ds.cs=null; ds.ce=null; return; }
  if(ds.ce && !isDayBefore(ds.ce, ds.s)) ds.ce=null;
}
function validateDateFilterApply(ds){
  if(!ds.s) return "Start date is required.";
  if(!ds.e) return "End date is required.";
  if(ds.e<ds.s) return "End date should be greater than start date.";
  if(!ds.cmp) return "";
  if(!ds.comparisonName && !ds.cmpMode) return "Please select a comparison option.";
  if(!ds.cs||!ds.ce) return "Compare start date and end date are required.";
  if(ds.ce<ds.cs) return "Compare end date should be greater than compare start date.";
  if(isCustomComparisonFlag(ds.comparisonName||ds.cmpMode)){
    if(!isDayBefore(ds.cs, ds.s) || !isDayBefore(ds.ce, ds.s))
      return "Comparison period must be before the selected Start date.";
    if(dayCount(ds.cs,ds.ce)<dayCount(ds.s,ds.e))
      return "Compare start date and end date should be min date difference of start date and end date";
  }
  return "";
}
function showDateFilterError(msg){
  if(typeof alertify!=="undefined"){
    try{ alertify.set("notifier","position","top-right"); }catch(e){}
    alertify.error(msg);
    return;
  }
  toast(msg);
}
function buildOptionButtons(list, selectedName, flagAttr){
  let html="";
  const rows=flagAttr==="data-date-flag"||flagAttr==="data-compare-flag"
    ? filterDateOptionsForPage(list)
    : (list||[]);
  (rows||[]).forEach(row=>{
    const name=getFilterField(row,"FilterName")||"";
    const id=getFilterField(row,"FilterID");
    if(!name) return;
    if(flagAttr==="data-date-flag" && name==="Current Quarter" && html) html+='<div class="ga-div"></div>';
    html+=`<button type="button" class="ga-preset${selectedName===name?" sel":""}" ${flagAttr}="${String(name).replace(/"/g,"")}" data-id="${id}">${name}</button>`;
  });
  return html;
}
function markSelectedOption(root, attr, selectedName){
  if(!root) return;
  root.querySelectorAll("["+attr+"]").forEach(node=>{
    node.classList.toggle("sel", node.getAttribute(attr)===selectedName);
  });
}
function setDefaultComparison(ds){
  const first=DateFilter.comparisonOptions[0];
  if(!ds.comparisonName && first){
    ds.comparisonName=getFilterField(first,"FilterName")||"";
    ds.comparisonId=Number(getFilterField(first,"FilterID"));
    ds.cmpMode=first._mode||comparisonModeFromName(ds.comparisonName)||"prev_dow";
  }
}
function forceCustomPeriodFlag(ds, root){
  const customOpt=findFilterOption("Custom", DateFilter.dateOptions);
  ds.label="Custom";
  /* Guide: Custom flag is always "0" for Timesheet (and preferred generally). */
  const rawId=customOpt?Number(getFilterField(customOpt,"FilterID")):0;
  ds.filterId=(isTimesheetPage() || isNaN(rawId))?0:rawId;
  if(isTimesheetPage()) ds.filterId=0;
  DateFilter.selectedFilterId=ds.filterId;
  if(root) markSelectedOption(root,"data-date-flag","Custom");
}
function setCompareVisible(pop, ds){
  const box=pop.querySelector("#gaCompareList");
  const inputs=pop.querySelector("#gaCompareInputs");
  const sw=pop.querySelector("#gaCmp");
  const cmpRow=pop.querySelector(".ga-cmp");
  const compareOk=isDateFilterCompareEnabled();
  if(!compareOk){
    if(ds){
      ds.cmp=false;
      ds.comparisonName="";
      ds.comparisonId=null;
      ds.pickingCmp=null;
      ds.cs=null;
      ds.ce=null;
    }
    if(cmpRow) cmpRow.style.display="none";
    if(box) box.style.display="none";
    if(inputs) inputs.style.display="none";
    if(sw){
      sw.classList.remove("on");
      sw.disabled=true;
    }
    return;
  }
  const customCmp=!!(ds.cmp && isCustomComparisonFlag(ds.comparisonName));
  if(cmpRow) cmpRow.style.display="";
  if(box) box.style.display=ds.cmp?"":"none";
  if(inputs) inputs.style.display=ds.cmp?"":"none";
  if(sw){
    sw.disabled=false;
    sw.classList.toggle("on", !!ds.cmp);
  }
  markSelectedOption(pop,"data-compare-flag", ds.cmp?ds.comparisonName:"");
  [pop.querySelector("#gaCmpS"), pop.querySelector("#gaCmpE")].forEach(el=>{
    if(!el) return;
    el.classList.toggle("readonly", !customCmp);
    el.classList.toggle("ga-field-ro", !customCmp);
  });
  pop.querySelectorAll("[data-date-flag]").forEach(btn=>{
    const isCustom=String(btn.getAttribute("data-date-flag")||"").toLowerCase()==="custom";
    const lock=customCmp && !isCustom;
    btn.disabled=!!lock;
    btn.classList.toggle("ga-preset-disabled", !!lock);
  });
}
function applyCompareDatesFromRow(ds, row){
  ds.cs=parseFilterDate(getFilterField(row,"PreviousStartDate"));
  ds.ce=parseFilterDate(getFilterField(row,"PreviousEndDate"));
  return !!(ds.cs && ds.ce);
}
function applyRangeToPicker(ds, row){
  const s=parseFilterDate(getFilterField(row,"CurrentStartDate"));
  const e=parseFilterDate(getFilterField(row,"CurrentEndDate"));
  if(!s||!e) return false;
  ds.s=s; ds.e=e; ds.pickingEnd=false;
  /* Added by Dipali V. on 01-10-2026 — align visible months to selection (quarter=3, Today/Yesterday keep focus month). */
  syncCalendarBaseToSelection(ds);
  const fid=Number(getFilterField(row,"FilterID"));
  if(!isNaN(fid)) ds.filterId=fid;
  DateFilter.selectedFilterId=ds.filterId;
  DateFilter.lastRange=row;
    /* Modify By Madhuri.K On 28-09-2026 */
  const ps=parseFilterDate(getFilterField(row,"PreviousStartDate"));
  const pe=parseFilterDate(getFilterField(row,"PreviousEndDate"));
  if(ps && pe){
    ds.cs=ps;
    ds.ce=pe;
  }else{
    seedCompareDates(ds);
  }
  return true;
}
function ensureLocalFilterOptions(){
  if(DateFilter.dateOptions.length) return;
  DateFilter.dateOptions=GA_PRESETS.filter(([l])=>l!=="divider").map(([l,fn],i)=>({FilterName:l, FilterID:i+1, _fn:fn, IsComparison:false}));
  DateFilter.comparisonOptions=GA_COMPARE_MODES.map((m,i)=>({FilterName:m.label, FilterID:i+1, _mode:m.id, IsComparison:true}));
  DateFilter.filterOptionsLoaded=true;
}
function GetFilterOption(onDone){
  if(DateFilter.filterOptionsLoaded && DateFilter.dateOptions.length){
    if(onDone) onDone(DateFilter.dateOptions, DateFilter.comparisonOptions);
    return;
  }
  if(!canUseFilterApis()){
    ensureLocalFilterOptions();
    if(onDone) onDone(DateFilter.dateOptions, DateFilter.comparisonOptions);
    return;
  }
  const body={dashboardID:getFilterDashboardId()};
    /* Modify By Madhuri.K On 28-09-2026 */
  if(isTimesheetPage()){
    const dash=getTimesheetDashboardId();
    callFilterDashboardApi("GetPageGenericfilters", {dashboardID:dash, isComparison:false}, function(dateJson){
      const dateRows=getApiRows(dateJson, "PageGenericFilterModel").filter(function(row){ return !isComparisonRow(row); });
      callFilterDashboardApi("GetPageGenericfilters", {dashboardID:dash, isComparison:true}, function(cmpJson){
        DateFilter.dateOptions=dateRows.length?dateRows:(ensureLocalFilterOptions(), DateFilter.dateOptions);
        const cmpRows=getApiRows(cmpJson, "PageGenericFilterModel");
        DateFilter.comparisonOptions=cmpRows.length?cmpRows:DateFilter.comparisonOptions;
        DateFilter.filterOptionsLoaded=true;
        if(onDone) onDone(DateFilter.dateOptions, DateFilter.comparisonOptions);
      }, function(){
        DateFilter.dateOptions=dateRows.length?dateRows:(ensureLocalFilterOptions(), DateFilter.dateOptions);
        if(!DateFilter.comparisonOptions.length) ensureLocalFilterOptions();
        DateFilter.filterOptionsLoaded=true;
        if(onDone) onDone(DateFilter.dateOptions, DateFilter.comparisonOptions);
      });
    }, function(){
      ensureLocalFilterOptions();
      if(onDone) onDone(DateFilter.dateOptions, DateFilter.comparisonOptions);
    });
    return;
  }
  callFilterDashboardApi("GetPageGenericfilters", body, function(json){
    const rows=getApiRows(json, "PageGenericFilterModel");
    const dateOptions=[], comparisonOptions=[];
    rows.forEach(row=>{
      if(isComparisonRow(row)) comparisonOptions.push(row);
      else dateOptions.push(row);
    });
    if(!dateOptions.length){
      ensureLocalFilterOptions();
    }else{
      DateFilter.dateOptions=dateOptions;
      DateFilter.comparisonOptions=comparisonOptions;
      DateFilter.filterOptionsLoaded=true;
    }
    if(onDone) onDone(DateFilter.dateOptions, DateFilter.comparisonOptions);
  }, function(){
    ensureLocalFilterOptions();
    if(onDone) onDone(DateFilter.dateOptions, DateFilter.comparisonOptions);
  });
}
function GetFilterDateRange(flag, startDate, endDate, onDone){
  const rawFlag=flag!=null && flag!==""?String(flag):"";
  const flagVal=resolveDateRangeFlag(rawFlag);
  const nameHint=(/^\d+$/.test(flagVal) || flagVal==="0")?"":flagVal;
  function finish(row){
    const overlaid=overlayTimesheetDateRow(row, nameHint || (row?getFilterField(row,"FilterName"):"") || rawFlag);
    if(onDone) onDone(overlaid);
  }
  if(!canUseFilterApis()){
    ensureLocalFilterOptions();
    const opt=DateFilter.dateOptions.find(o=>String(getFilterField(o,"FilterID"))===flagVal || String(getFilterField(o,"FilterName"))===flagVal || String(getFilterField(o,"FilterName"))===rawFlag);
    if(opt && opt._fn){
      const [s,e]=opt._fn();
      const [ps,pe]=computeCompareRange(s, e, "prev");
      finish({
        CurrentStartDate:s,
        CurrentEndDate:e,
        FilterID:getFilterField(opt,"FilterID"),
        FilterName:getFilterField(opt,"FilterName"),
        PreviousStartDate:ps,
        PreviousEndDate:pe
      });
        /* Modify By Madhuri.K On 28-09-2026 */
      return;
    }
    const pair=localPresetRange(nameHint||rawFlag);
    if(pair){
      const [s,e]=pair;
      const [ps,pe]=computeCompareRange(s, e, "prev");
      finish({CurrentStartDate:s, CurrentEndDate:e, PreviousStartDate:ps, PreviousEndDate:pe, FilterName:nameHint||rawFlag, FilterID:0});
      return;
    }
    if(onDone) onDone(null);
    return;
  }
  const key=flagVal+"|"+(startDate||"")+"|"+(endDate||"");
  if(!startDate && DateFilter.dateRangeCache[key]){
    finish(DateFilter.dateRangeCache[key]);
    return;
  }
  const body={dashboardID:getFilterDashboardId(), flag:flagVal};
  if(startDate) body.startDate=startDate;
  if(endDate) body.endDate=endDate;
  callFilterDashboardApi("GetAnalyticsDBFilterDateRange", body, function(json){
    const row=getApiRows(json, "AnalyticsDBFilterDateRangeModel")[0]||null;
    if(row && !startDate) DateFilter.dateRangeCache[key]=row;
    finish(row);
  }, function(){
    ensureLocalFilterOptions();
    const opt=DateFilter.dateOptions.find(o=>String(getFilterField(o,"FilterID"))===flagVal || String(getFilterField(o,"FilterName"))===flagVal || String(getFilterField(o,"FilterName"))===rawFlag);
    if(opt && opt._fn){
      const [s,e]=opt._fn();
      const [ps,pe]=computeCompareRange(s, e, "prev");
      finish({
        CurrentStartDate:s,
        CurrentEndDate:e,
        FilterID:getFilterField(opt,"FilterID"),
        FilterName:getFilterField(opt,"FilterName"),
        PreviousStartDate:ps,
        PreviousEndDate:pe
      });
      return;
    }
    const pair=localPresetRange(nameHint||rawFlag);
    if(pair){
      const [s,e]=pair;
      const [ps,pe]=computeCompareRange(s, e, "prev");
      finish({CurrentStartDate:s, CurrentEndDate:e, PreviousStartDate:ps, PreviousEndDate:pe, FilterName:nameHint||rawFlag, FilterID:0});
      return;
    }
    if(onDone) onDone(null);
  });
}
function GetFilterCompareDateRange(filterId, comparisonId, startDate, endDate, onDone){
  if(!comparisonId || !startDate || !endDate){ if(onDone) onDone(null); return; }
  if(!canUseFilterApis()){
    ensureLocalFilterOptions();
    const opt=DateFilter.comparisonOptions.find(o=>Number(o.FilterID)===Number(comparisonId));
    const [cs,ce]=computeCompareRange(startDate, endDate, (opt&&opt._mode)||"prev_dow");
    if(onDone) onDone({PreviousStartDate:cs, PreviousEndDate:ce, FilterID:filterId, ComparisonID:comparisonId});
    return;
  }
  const body={
    DashboardID:getFilterDashboardId(),
    FilterID:Number(filterId)||0,
    IsComparison:true,
    ComparisonID:Number(comparisonId),
    CustomCompStartDate:formatApiDate(startDate),
    CustomCompEndDate:formatApiDate(endDate)
  };
  const key=body.FilterID+"|"+body.ComparisonID+"|"+body.CustomCompStartDate+"|"+body.CustomCompEndDate;
  if(DateFilter.compareRangeCache[key]){
    if(onDone) onDone(DateFilter.compareRangeCache[key]);
    return;
  }
  callFilterDashboardApi("GetAnalyticsDBFilterDateRangeUpdated", body, function(json){
    const row=getApiRows(json, "AnalyticsDBFilterDateRangeModel")[0]||null;
    if(row) DateFilter.compareRangeCache[key]=row;
    if(onDone) onDone(row);
  }, function(){
    ensureLocalFilterOptions();
    const opt=DateFilter.comparisonOptions.find(o=>Number(o.FilterID)===Number(comparisonId));
    const [cs,ce]=computeCompareRange(startDate, endDate, (opt&&opt._mode)||"prev_dow");
    if(onDone) onDone({PreviousStartDate:cs, PreviousEndDate:ce, FilterID:filterId, ComparisonID:comparisonId});
  });
}
function syncDateFilterToState(){
  const s=DateFilter.startDate, e=DateFilter.endDate;
  const days=(s&&e)?Math.round((e-s)/864e5)+1:1;
  const rangeText=(s&&e)?rangeLbl(s,e):"";
  const cmpMode=DateFilter.compare
    ? comparisonModeFromName(DateFilter.selectedComparisonName||"prev_dow")
    : "prev_dow";
  let cs=DateFilter.previousStart, ce=DateFilter.previousEnd;
  if((!cs||!ce) && s && e){
    const computed=computeCompareRange(s,e,cmpMode==="custom"?"prev":cmpMode);
    cs=computed[0]; ce=computed[1];
    DateFilter.previousStart=cs;
    DateFilter.previousEnd=ce;
  }
  state.date={
    label:DateFilter.selectedFilterName||DEFAULT_DATE_OPTION,
    range:rangeText,
    months:Math.max(days/30.42, 0.1),
    compare:!!DateFilter.compare,
    compareMode:cmpMode,
    comparisonName:DateFilter.selectedComparisonName||"",
    comparisonId:DateFilter.selectedComparisonId,
    filterId:DateFilter.selectedFilterId,
    s:s, e:e,
    cs:cs?cloneDate(cs):null,
    ce:ce?cloneDate(ce):null
  };
  if(typeof window!=="undefined"){
    window.TimesheetCompareState=window.TimesheetCompareState||{};
    TimesheetCompareState.isComparison=!!DateFilter.compare;
    TimesheetCompareState.comparisonID=DateFilter.selectedComparisonId||0;
    TimesheetCompareState.comparisonName=DateFilter.selectedComparisonName||"previous period";
    TimesheetCompareState.comparisonStartDate=formatKpiApiDate(DateFilter.previousStart)||"";
    TimesheetCompareState.comparisonEndDate=formatKpiApiDate(DateFilter.previousEnd)||"";
  }
  syncDateUI();
}
function applyFilterDateRange(row, filterName){
  if(!row) return false;
  const s=parseFilterDate(getFilterField(row,"CurrentStartDate"));
  const e=parseFilterDate(getFilterField(row,"CurrentEndDate"));
  if(!s||!e) return false;
  const filterId=Number(getFilterField(row,"FilterID"));
  DateFilter.selectedFilterId=isNaN(filterId)?DateFilter.selectedFilterId:filterId;
  if(isTimesheetPage() && String(filterName||getFilterField(row,"FilterName")||"").toLowerCase()==="custom"){
    DateFilter.selectedFilterId=0;
  }
  DateFilter.selectedFilterName=filterName||getFilterField(row,"FilterName")||DEFAULT_DATE_OPTION;
  DateFilter.lastRange=row;
  DateFilter.startDate=s;
  DateFilter.endDate=e;
  DateFilter.previousStart=parseFilterDate(getFilterField(row,"PreviousStartDate"));
  DateFilter.previousEnd=parseFilterDate(getFilterField(row,"PreviousEndDate"));
  syncDateFilterToState();
  return true;
}
function InitSharedDateFilter(onDone){
  GetFilterOption(function(dateOptions){
    const def=getDefaultDateOption(dateOptions);
    if(!def){
      refreshRelativeDateState();
      syncDateFilterFromState();
      if(onDone) onDone(false);
      return;
    }
    GetFilterDateRange(String(getFilterField(def,"FilterName")||getFilterField(def,"FilterID")), null, null, function(row){
      if(!applyFilterDateRange(row, getFilterField(def,"FilterName"))){
        refreshRelativeDateState();
        syncDateFilterFromState();
        if(onDone) onDone(false);
        return;
      }
      if(onDone) onDone(true);
    });
    /* Seed default comparison option only — do not turn Compare on.
       Calendar Compare stays off until user toggles it (same as CXO). */
    if(DateFilter.comparisonOptions && DateFilter.comparisonOptions.length && DateFilter.selectedComparisonId==null){
      const first=DateFilter.comparisonOptions[0];
      DateFilter.selectedComparisonName=getFilterField(first,"FilterName")||"previous period";
      DateFilter.selectedComparisonId=Number(getFilterField(first,"FilterID"))||null;
    }
  });
}
function syncDateFilterFromState(){
  DateFilter.selectedFilterName=state.date.label||DEFAULT_DATE_OPTION;
  DateFilter.selectedFilterId=state.date.filterId||null;
  DateFilter.startDate=state.date.s?cloneDate(state.date.s):null;
  DateFilter.endDate=state.date.e?cloneDate(state.date.e):null;
  DateFilter.compare=!!state.date.compare;
  DateFilter.selectedComparisonName=state.date.comparisonName||"";
  DateFilter.selectedComparisonId=state.date.comparisonId||null;
  DateFilter.previousStart=state.date.cs?cloneDate(state.date.cs):null;
  DateFilter.previousEnd=state.date.ce?cloneDate(state.date.ce):null;
}
function comparisonModeFromName(name){
  const n=String(name||"").replace(/\s+/g,"").toLowerCase();
  if(n==="customcomparison"||n==="custom") return "custom";
  const m=GA_COMPARE_MODES.find(x=>x.id===name || String(x.label).replace(/\s+/g,"").toLowerCase()===n);
  return m?m.id:"prev_dow";
}
function comparisonOptionFromMode(mode){
  if(!DateFilter.comparisonOptions.length) ensureLocalFilterOptions();
  return DateFilter.comparisonOptions.find(o=>{
    if(o._mode===mode) return true;
    return comparisonModeFromName(getFilterField(o,"FilterName"))===mode;
  }) || DateFilter.comparisonOptions[0] || null;
}
function computeCompareRange(s, e, mode, customCs, customCe){
  if(!s || !e) return [null, null];
  const days=dayCount(s,e);
  if(mode==="prev"){
    const ce=addD(s,-1);
    return [addD(ce,-(days-1)), ce];
  }
  if(mode==="prev_dow"){
    const shift=Math.ceil(days/7)*7;
    return [addD(s,-shift), addD(e,-shift)];
  }
  if(mode==="prev_year"){
    return [addYearsKeepDate(s,-1), addYearsKeepDate(e,-1)];
  }
  if(mode==="prev_year_dow"){
    return [addD(s,-364), addD(e,-364)];
  }
  if(mode==="custom"){
    if(customCs && customCe) return [cloneDate(customCs), cloneDate(customCe)];
    const ce=addD(s,-1);
    return [addD(ce,-(days-1)), ce];
  }
  const ce=addD(s,-1);
  return [addD(ce,-(days-1)), ce];
}
function applyCompareDates(dateObj){
  if(!dateObj || !dateObj.compare || !dateObj.s || !dateObj.e) {
    if(dateObj){ dateObj.cs=null; dateObj.ce=null; }
    return;
  }
  if(dateObj.compareMode==="custom" && dateObj.cs && dateObj.ce) return;
  const [cs,ce]=computeCompareRange(dateObj.s, dateObj.e, dateObj.compareMode||"prev_dow", dateObj.cs, dateObj.ce);
  dateObj.cs=cs; dateObj.ce=ce;
}
/* Indian FY (Apr-Mar). Quarters: 0=Apr-Jun, 1=Jul-Sep, 2=Oct-Dec, 3=Jan-Mar */
const fyStartYear=d=>d.getMonth()>=3 ? d.getFullYear() : d.getFullYear()-1;
const fyQuarterIndex=d=>{
  const m=d.getMonth();
  if(m>=3&&m<=5) return 0;
  if(m>=6&&m<=8) return 1;
  if(m>=9&&m<=11) return 2;
  return 3;
};
const fyQuarterBounds=(fyYear,q)=>{
  if(q===0) return [new Date(fyYear,3,1), new Date(fyYear,5,30)];
  if(q===1) return [new Date(fyYear,6,1), new Date(fyYear,8,30)];
  if(q===2) return [new Date(fyYear,9,1), new Date(fyYear,11,31)];
  return [new Date(fyYear+1,0,1), new Date(fyYear+1,2,31)];
};
function currentQuarterRange(d){
  const today=d||getToday();
  const fy=fyStartYear(today);
  const q=fyQuarterIndex(today);
  const [s]=fyQuarterBounds(fy,q);
  return [s, today];
}
function previousQuarterRange(d){
  const today=d||getToday();
  let fy=fyStartYear(today);
  let q=fyQuarterIndex(today)-1;
  if(q<0){ q=3; fy-=1; }
  return fyQuarterBounds(fy,q);
}
function currentFYRange(d){
  const today=d||getToday();
  const fy=fyStartYear(today);
  return [new Date(fy,3,1), today];
}
function previousFYRange(d){
  const today=d||getToday();
  const fy=fyStartYear(today);
  return [new Date(fy-1,3,1), new Date(fy,2,31)];
}
function defaultDateState(){
  const [s,e]=currentQuarterRange();
  const d={label:"Current Quarter", range:rangeLbl(s,e), months:Math.max((Math.round((e-s)/864e5)+1)/30.42,0.1), compare:false, compareMode:"prev_dow", s, e, cs:null, ce:null};
  applyCompareDates(d);
  return d;
}
/** Recompute presets that are relative to "today" so the UI always matches the real calendar */
function refreshRelativeDateState(){
  const map={
    "Today":()=>{const t=getToday(); return [t,t];},
    "Yesterday":()=>{const t=getToday(),y=addD(t,-1); return [y,y];},
    "This week (Sun - Today)":()=>{const t=getToday(); return [sow(t),t];},
    "Last 7 days":()=>{const t=getToday(); return [addD(t,-6),t];},
    "Last 28 days":()=>{const t=getToday(); return [addD(t,-27),t];},
    "Last 30 days":()=>{const t=getToday(); return [addD(t,-29),t];},
    "This month":()=>{const t=getToday(); return [startOfMonth(t),t];},
    "Current Quarter":()=>currentQuarterRange(),
    "Current Financial Year":()=>currentFYRange(),
    "Last 12 months":()=>{const t=getToday(); return [addD(t,-364),t];}
  };
  const fn=map[state.date.label];
  if(!fn){
    if(!(state.date.s instanceof Date) || !(state.date.e instanceof Date)){
      Object.assign(state.date, defaultDateState());
    }
    return;
  }
  const [s,e]=fn();
  state.date.s=s;
  state.date.e=e;
  state.date.range=rangeLbl(s,e);
  state.date.months=Math.max((Math.round((e-s)/864e5)+1)/30.42,0.1);
  applyCompareDates(state.date);
}
const GA_PRESETS=[
 ["Custom",null],
 ["Today",()=>{const t=getToday(); return [t,t];}],
 ["Yesterday",()=>{const t=getToday(),y=addD(t,-1); return [y,y];}],
 ["This week (Sun - Today)",()=>{const t=getToday(); return [sow(t),t];}],
 ["Last 7 days",()=>{const t=getToday(); return [addD(t,-6),t];}],
 ["Last week (Sun - Sat)",()=>{const t=getToday(); return [addD(sow(t),-7),addD(sow(t),-1)];}],
 ["Last 28 days",()=>{const t=getToday(); return [addD(t,-27),t];}],
 ["Last 30 days",()=>{const t=getToday(); return [addD(t,-29),t];}],
 ["This month",()=>{const t=getToday(); return [startOfMonth(t),t];}],
 ["Last month",()=>{const t=getToday(); const lm=new Date(t.getFullYear(),t.getMonth()-1,1); return [lm,endOfMonth(lm)];}],
 ["divider",null],
 ["Current Quarter",()=>currentQuarterRange()],
 ["Previous Quarter",()=>previousQuarterRange()],
 ["Current Financial Year",()=>currentFYRange()],
 ["Previous Financial Year",()=>previousFYRange()],
 ["Last 12 months",()=>{const t=getToday(); return [addD(t,-364),t];}]
];
function localPresetRange(name){
  const n=String(name||"").trim().toLowerCase();
  if(!n || n==="custom" || n==="0" || n==="divider") return null;
  const hit=GA_PRESETS.find(function(p){ return p[0]!=="divider" && String(p[0]).toLowerCase()===n; });
  if(!hit || typeof hit[1]!=="function") return null;
  return hit[1]();
}
function overlayTimesheetDateRow(row, flagName){
  if(!isTimesheetPage()) return row;
  const name=String(flagName||getFilterField(row,"FilterName")||"").trim();
  if(!name || name.toLowerCase()==="custom" || name==="0") return row;
  const pair=localPresetRange(name);
  if(!pair) return row;
  const s=pair[0], e=pair[1];
  const mode=comparisonModeFromName(DateFilter.selectedComparisonName||"prev_dow");
  const computed=computeCompareRange(s, e, mode==="custom"?"prev":mode);
  const out=Object.assign({}, row||{});
  out.CurrentStartDate=s;
  out.CurrentEndDate=e;
  out.PreviousStartDate=computed[0];
  out.PreviousEndDate=computed[1];
  out.FilterName=name;
  return out;
}
function seedCompareDates(ds){
  if(!ds || (ds.cs && ds.ce) || !ds.s || !ds.e) return;
  const mode=ds.cmpMode||comparisonModeFromName(ds.comparisonName||"prev_dow");
  const pair=computeCompareRange(ds.s, ds.e, mode==="custom"?"prev":mode);
  ds.cs=pair[0];
  ds.ce=pair[1];
}
function closeDatePicker(){
  document.querySelectorAll(".ga-pop").forEach(pop=>{
    if(pop._onDocClose) document.removeEventListener("mousedown", pop._onDocClose, true);
    if(pop.parentNode) pop.parentNode.removeChild(pop);
  });
}
function placeDatePicker(pop, anchor){
  const r=anchor.getBoundingClientRect(), pad=10;
  const pw=Math.min(602, window.innerWidth - pad*2);
  const spaceBelow=window.innerHeight - r.bottom - pad - 8;
  const spaceAbove=r.top - pad - 8;
  let maxH=Math.max(280, Math.min(window.innerHeight - pad*2, Math.max(spaceBelow, spaceAbove, 360)));
  pop.style.maxHeight=maxH+"px";
  const ph=pop.offsetHeight || 420;
  let top=r.bottom+8;
  let left=Math.min(Math.max(pad, r.left), window.innerWidth - pw - pad);
  if(top + ph > window.innerHeight - pad){
    if(spaceAbove >= Math.min(ph, 320) && spaceAbove > spaceBelow){
      top=Math.max(pad, r.top - ph - 8);
      maxH=Math.max(280, r.top - pad - 8);
    } else {
      top=pad;
      maxH=Math.max(280, window.innerHeight - pad*2);
    }
  }
  if(top < pad) top=pad;
  maxH=Math.max(280, Math.min(maxH, window.innerHeight - top - pad));
  pop.style.cssText="position:fixed;top:"+top+"px;left:"+left+"px;width:"+pw+"px;max-height:"+maxH+"px;right:auto;bottom:auto;z-index:3000;overflow:auto;";
}
/* Added by Dipali V. on 01-10-2026 — Quarter presets show 3 months; Today/Yesterday keep selected month in view. */
function isQuarterDateFlag(name){
  return /quarter/i.test(String(name||""));
}
function calendarVisibleMonthCount(ds){
  /* Added by Dipali V. on 01-10-2026 — single-day / single-month presets show 1 month so highlight fits. */
  if(ds && ds.s && ds.e && sameD(ds.s, ds.e)) return 1;
  if(isQuarterDateFlag(ds && ds.label)) return 3;
  if(ds && ds.s && ds.e){
    const span=(ds.e.getFullYear()-ds.s.getFullYear())*12+(ds.e.getMonth()-ds.s.getMonth())+1;
    if(span>=3) return 3;
    if(span<=1) return 1;
  }
  return 2;
}
function syncCalendarBaseToSelection(ds){
  if(!ds) return;
  /* Added by Dipali V. on 01-10-2026 — always focus calendar on the selected period's start month
     (This month / Today / Quarter / etc.) so the range is visible and highlighted. */
  if(ds.s){
    ds.base=new Date(ds.s.getFullYear(), ds.s.getMonth(), 1);
    return;
  }
  if(ds.e){
    ds.base=new Date(ds.e.getFullYear(), ds.e.getMonth(), 1);
  }
}
/* Added by Dipali V. on 01-10-2026 — scroll #gaCals so highlighted day is fully visible (not clipped by footer). */
function scrollCalendarToHighlightedDay(gaCals){
  if(!gaCals) return;
  const focus=
    gaCals.querySelector(".ga-day.st")||
    gaCals.querySelector(".ga-day.sel")||
    gaCals.querySelector(".ga-day.en");
  if(!focus){
    gaCals.scrollTop=0;
    return;
  }
  gaCals.style.overflowY="auto";
  const calsRect=gaCals.getBoundingClientRect();
  const dayRect=focus.getBoundingClientRect();
  /* Always compute target from content coords — works even when day is only partially visible. */
  const relativeTop=dayRect.top-calsRect.top+gaCals.scrollTop;
  const pad=10;
  const target=relativeTop-pad;
  const maxScroll=Math.max(0, gaCals.scrollHeight-gaCals.clientHeight);
  gaCals.scrollTop=Math.max(0, Math.min(target, maxScroll));
}
function queueScrollCalendarToHighlight(gaCals){
  /* Added by Dipali V. on 01-10-2026 — retry after layout so max-height / flex size are final. */
  const run=function(){ scrollCalendarToHighlightedDay(gaCals); };
  if(typeof requestAnimationFrame==="function"){
    requestAnimationFrame(function(){
      requestAnimationFrame(run);
    });
  }
  setTimeout(run, 0);
  setTimeout(run, 50);
}
function buildCalendarMonth(year, month, ds, today){
  const first=new Date(year, month, 1), dim=new Date(year, month+1, 0).getDate();
  let cells="", i, d, dt, dis, st, en, inr, cst, cen, cinr, cls, singleDay;
  /* Added by Dipali V. on 01-10-2026 — single-day presets (Today/Yesterday) need a clear selected highlight. */
  singleDay=!!(ds.s && ds.e && sameD(ds.s, ds.e));
  for(i=0;i<first.getDay();i++) cells+='<span class="ga-day blank"></span>';
  for(d=1;d<=dim;d++){
    dt=new Date(year, month, d);
    /* Future days disabled; Custom Comparison pick also disables on/after current Start Date. */
    dis=dt>today || isCustomCompareDayDisabled(dt, ds);
    st=sameD(dt, ds.s);
    en=sameD(dt, ds.e);
    inr=ds.s && ds.e && dt>ds.s && dt<ds.e;
    cst=ds.cmp && sameD(dt, ds.cs);
    cen=ds.cmp && sameD(dt, ds.ce);
    cinr=ds.cmp && ds.cs && ds.ce && dt>ds.cs && dt<ds.ce;
    cls="ga-day"+(dis?" dis":"")+(st?" st":"")+(en?" en":"")+(inr?" inr":"");
    /* Added by Dipali V. on 01-10-2026 — force selected style when start===end (Today/Yesterday). */
    if(singleDay && (st||en)) cls+=" sel";
    if(!st && !en && !inr){
      if(cst||cen) cls+=cst?" cst cmp-st":" cen cmp-en";
      else if(cinr) cls+=" cinr cmp-inr";
    }
    if(sameD(dt, today)) cls+=" tdy";
    cells+='<span class="'+cls+'"'+(dis?"":' data-d="'+year+"-"+month+"-"+d+'"')+">"+d+"</span>";
  }
  return '<div class="ga-mon">'+first.toLocaleDateString("en-US",{month:"long",year:"numeric"})+"</div><div class=\"ga-grid\">"+cells+"</div>";
}
function openDatePicker(evt){
  closeDatePicker();
  closeMenus();
  /* CXO top chips use .pop — clear via page helper when present. */
  if(typeof window.closeTopFilterPop==="function"){
    try{ window.closeTopFilterPop(); }catch(e){ /* ignore */ }
  }
  GetFilterOption(function(){
    openDatePickerReady(evt);
  });
}
function openDatePickerReady(evt){
  const today=getToday();
  const fallback=currentQuarterRange(today);
  const start0=DateFilter.startDate || (state.date.s instanceof Date ? state.date.s : (parseSavedDate(state.date.s) || fallback[0]));
  const end0=DateFilter.endDate || (state.date.e instanceof Date ? state.date.e : (parseSavedDate(state.date.e) || fallback[1]));
  const cmpOn=isDateFilterCompareEnabled()
    ? (DateFilter.compare!=null?!!DateFilter.compare:!!state.date.compare)
    : false;
  const cmpOpt=comparisonOptionFromMode(state.date.compareMode||"prev_dow");
  const cmpName=cmpOn
    ? (DateFilter.selectedComparisonName || (cmpOpt && getFilterField(cmpOpt,"FilterName")) || state.date.comparisonName || "")
    : "";
  const cmpId=cmpOn
    ? (DateFilter.selectedComparisonId || (cmpOpt && getFilterField(cmpOpt,"FilterID")) || state.date.comparisonId || null)
    : null;
  const ds={
    s:new Date(start0.getFullYear(),start0.getMonth(),start0.getDate()),
    e:new Date(end0.getFullYear(),end0.getMonth(),end0.getDate()),
    cs:cmpOn ? cloneDate(DateFilter.previousStart || state.date.cs) : null,
    ce:cmpOn ? cloneDate(DateFilter.previousEnd || state.date.ce) : null,
    filterId:DateFilter.selectedFilterId || state.date.filterId || null,
    label:DateFilter.selectedFilterName || state.date.label || DEFAULT_DATE_OPTION,
    comparisonName:cmpName,
    comparisonId:cmpId,
    cmpMode:state.date.compareMode||comparisonModeFromName(cmpName)||"prev_dow",
    cmp:cmpOn,
    pickingEnd:false,
    pickingCmp:null,
    base:new Date(end0.getFullYear(), end0.getMonth()-1, 1)
  };
  /* Added by Dipali V. on 01-10-2026 — open picker already aligned to quarter / single-day selection. */
  syncCalendarBaseToSelection(ds);
  const anchor=evt.currentTarget;
  const pop=document.createElement("div");
  pop.className="pop ga-pop";
  pop.setAttribute("role","dialog");
  pop.setAttribute("aria-label","Date range");
  pop.innerHTML=
    '<div class="ga-presets" id="gaPresets"></div>'+
    '<div class="ga-right">'+
      '<div class="ga-inputs">'+
        '<div class="ga-field active" id="gaS"><label>Start date</label><span></span></div>'+
        '<div class="ga-field" id="gaE"><label>End date</label><span></span></div>'+
      "</div>"+
      '<div id="gaCompareInputs" style="display:none">'+
        '<div class="ga-cmp-caption">Compare</div>'+
        '<div class="ga-inputs">'+
          '<div class="ga-field" id="gaCmpS"><label>Start date</label><span></span></div>'+
          '<div class="ga-field" id="gaCmpE"><label>End date</label><span></span></div>'+
        "</div>"+
      "</div>"+
      '<div class="ga-nav"><button type="button" id="gaPrev" title="Earlier month">&#8249;</button>'+
        '<button type="button" id="gaNext" title="Later month">&#8250;</button></div>'+
      '<div class="ga-dow"><span>S</span><span>M</span><span>T</span><span>W</span><span>T</span><span>F</span><span>S</span></div>'+
      '<div class="ga-cals" id="gaCals"></div>'+
      '<div class="ga-foot">'+
        '<button type="button" class="ga-btn" id="gaCancel">Cancel</button>'+
        '<button type="button" class="ga-btn pri" id="gaApply">Apply</button>'+
      "</div>"+
    "</div>";
  document.body.appendChild(pop);
  pop.addEventListener("click", ev=>ev.stopPropagation());
  pop.addEventListener("mousedown", ev=>ev.stopPropagation());

    const presets=pop.querySelector("#gaPresets");
    const gaS=pop.querySelector("#gaS");
    const gaE=pop.querySelector("#gaE");
  const gaCmpS=pop.querySelector("#gaCmpS");
  const gaCmpE=pop.querySelector("#gaCmpE");
    const gaCals=pop.querySelector("#gaCals");

  function paintInputs(){
    const cmpPick=!!(ds.cmp && ds.pickingCmp && isCustomComparisonFlag(ds.comparisonName));
    /* Added by Dipali V. on 01-10-2026 — Custom / Custom Comparison: Start can take focus like End
       (do not force End active just because both dates are already set). */
    const focusEnd=!cmpPick && !!ds.pickingEnd;
    gaS.querySelector("span").textContent=fmtD(ds.s);
    gaE.querySelector("span").textContent=ds.e?fmtD(ds.e):"-";
    gaS.classList.toggle("active", !cmpPick && !focusEnd);
    gaE.classList.toggle("active", !cmpPick && focusEnd);
    if(gaCmpS){
      gaCmpS.querySelector("span").textContent=ds.cs?fmtD(ds.cs):"-";
      gaCmpS.classList.toggle("active", cmpPick && ds.pickingCmp==="s");
    }
    if(gaCmpE){
      gaCmpE.querySelector("span").textContent=ds.ce?fmtD(ds.ce):"-";
      gaCmpE.classList.toggle("active", cmpPick && ds.pickingCmp==="e");
    }
  }
  function paintCalendar(){
    paintInputs();
    setCompareVisible(pop, ds);
    /* Added by Dipali V. on 01-10-2026 — Current/Previous Quarter paint 3 months; others keep 2. */
    const monthCount=calendarVisibleMonthCount(ds);
    let html="", mi;
    for(mi=0;mi<monthCount;mi++){
      html+=buildCalendarMonth(ds.base.getFullYear(), ds.base.getMonth()+mi, ds, today);
    }
    gaCals.innerHTML=html;
    gaCals.classList.toggle("ga-cals-quarter", monthCount>=3);
    /* Added by Dipali V. on 01-10-2026 — room for full month weeks / quarter months + force scrollable. */
    gaCals.style.overflowY="auto";
    gaCals.style.maxHeight=monthCount>=3?"360px":(monthCount===1?"280px":"248px");
    placeDatePicker(pop, anchor);
    /* Added by Dipali V. on 01-10-2026 — auto-scroll so the highlighted start/end day stays visible. */
    queueScrollCalendarToHighlight(gaCals);
  }
  function loadCompareRange(forceSeed){
    let prev;
    if(!ds.cmp || !ds.s || !ds.e){
      paintCalendar();
      return;
    }
    /* Custom Comparison: seed equal-length window ending day before current Start; never overlap. */
    if(isCustomComparisonFlag(ds.comparisonName)){
      if(forceSeed || !ds.cs || !ds.ce){
        prev=computePreviousPeriodEqualLength(ds.s, ds.e);
        ds.cs=prev.start;
        ds.ce=prev.end;
      }
      clampCustomCompareToBeforeStart(ds);
      paintCalendar();
      return;
    }
    /* Added by Dipali V. on 01-10-2026 — Custom period: equal-length prior window locally (CXO). */
    if(isCustomPeriodFlag(ds.label) && !isCustomComparisonFlag(ds.comparisonName)){
      prev=computePreviousPeriodEqualLength(ds.s, ds.e);
      ds.cs=prev.start;
      ds.ce=prev.end;
      paintCalendar();
      return;
    }
    /* Previous period: prefer lastRange Previous* so as-of stays aligned with current flag. */
    if(isAlignedPreviousPeriodComparison(ds.comparisonName)){
      if(!applyPreviousDatesFromRangeRow(ds, DateFilter.lastRange) && ds.s && ds.e){
        prev=computePreviousPeriodEqualLength(ds.s, ds.e);
        ds.cs=prev.start;
        ds.ce=prev.end;
      }
      paintCalendar();
      return;
    }
    if(isTimesheetPage() && !isCustomComparisonFlag(ds.comparisonName)){
      if(forceSeed || !ds.cs || !ds.ce){
        ds.cs=null;
        ds.ce=null;
        seedCompareDates(ds);
      }
      paintCalendar();
      return;
    }
    if(!ds.comparisonId){
      seedCompareDates(ds);
      paintCalendar();
      return;
    }
    GetFilterCompareDateRange(ds.filterId!=null?ds.filterId:DateFilter.selectedFilterId, ds.comparisonId, ds.s, ds.e, function(row){
      if(row) applyCompareDatesFromRow(ds, row);
      seedCompareDates(ds);
      paintCalendar();
    });
  }

  presets.innerHTML=
    buildOptionButtons(DateFilter.dateOptions, ds.label, "data-date-flag")+
    (
      isDateFilterCompareEnabled()
        ? (
          '<div class="ga-cmp">Compare <button type="button" class="switch" id="gaCmp"></button></div>'+
          '<div id="gaCompareList">'+
            (DateFilter.comparisonOptions.length?'<div class="ga-div"></div>':'')+
            buildOptionButtons(DateFilter.comparisonOptions, ds.comparisonName, "data-compare-flag")+
          "</div>"
        )
        : ""
    );
  if(!isDateFilterCompareEnabled()){
    ds.cmp=false;
    ds.comparisonName="";
    ds.comparisonId=null;
    ds.pickingCmp=null;
    ds.cs=null;
    ds.ce=null;
  } else if(ds.cmp){
    setDefaultComparison(ds);
    if(isCustomComparisonFlag(ds.comparisonName)) forceCustomPeriodFlag(ds, presets);
  }
  setCompareVisible(pop, ds);

  presets.addEventListener("click", function(ev){
    const dateBtn=ev.target.closest?ev.target.closest("[data-date-flag]"):null;
    const compareBtn=ev.target.closest?ev.target.closest("[data-compare-flag]"):null;
    const sw=ev.target.closest?ev.target.closest("#gaCmp"):null;

    if(sw){
      if(!isDateFilterCompareEnabled()) return;
      ds.cmp=!ds.cmp;
      ds.pickingCmp=null;
      if(!ds.cmp){
        ds.comparisonName="";
        ds.comparisonId=null;
        ds.cs=null;
        ds.ce=null;
        setCompareVisible(pop, ds);
        paintCalendar();
        return;
      }
      setDefaultComparison(ds);
      if(isCustomComparisonFlag(ds.comparisonName)){
        forceCustomPeriodFlag(ds, presets);
        ds.pickingCmp="s";
        setCompareVisible(pop, ds);
        loadCompareRange(true);
        return;
      }
      setCompareVisible(pop, ds);
      loadCompareRange(true);
      return;
    }

    if(compareBtn){
      if(!ds.cmp) return;
      ds.comparisonName=compareBtn.getAttribute("data-compare-flag");
      ds.comparisonId=Number(compareBtn.getAttribute("data-id"));
      ds.cmpMode=comparisonModeFromName(ds.comparisonName);
      markSelectedOption(presets, "data-compare-flag", ds.comparisonName);
      if(isCustomComparisonFlag(ds.comparisonName)){
        forceCustomPeriodFlag(ds, presets);
        ds.pickingCmp="s";
        setCompareVisible(pop, ds);
        loadCompareRange(true);
        return;
      }
      ds.pickingCmp=null;
      setCompareVisible(pop, ds);
      loadCompareRange(true);
      return;
    }

    if(!dateBtn || dateBtn.disabled || dateBtn.classList.contains("ga-preset-disabled")) return;
    if(ds.cmp && isCustomComparisonFlag(ds.comparisonName) &&
        String(dateBtn.getAttribute("data-date-flag")||"").toLowerCase()!=="custom"){
      showDateFilterError("When Custom Comparison is selected, only Custom date range is allowed.");
      return;
    }
    ds.pickingCmp=null;
    ds.label=dateBtn.getAttribute("data-date-flag");
    markSelectedOption(presets, "data-date-flag", ds.label);
    if(String(ds.label).toLowerCase()==="custom"){
      ds.filterId=Number(dateBtn.getAttribute("data-id")||0);
      DateFilter.selectedFilterId=ds.filterId;
      paintCalendar();
      return;
    }
    GetFilterDateRange(ds.label, null, null, function(row){
      if(!row || !applyRangeToPicker(ds, row)) return;
      ds.filterId=Number(getFilterField(row,"FilterID")||dateBtn.getAttribute("data-id")||0);
      DateFilter.selectedFilterId=ds.filterId;
      DateFilter.selectedFilterName=ds.label;
      if(ds.cmp && !isCustomComparisonFlag(ds.comparisonName)) loadCompareRange(true);
      else {
        seedCompareDates(ds);
        paintCalendar();
      }
    });
  });

  gaCals.addEventListener("click", function(ev){
    const el=ev.target.closest?ev.target.closest("[data-d]"):null;
    if(!el) return;
    const p=el.getAttribute("data-d").split("-").map(Number);
    const dt=new Date(p[0], p[1], p[2]);
    if(ds.cmp && ds.pickingCmp && isCustomComparisonFlag(ds.comparisonName)){
      if(!isDateFilterCustomEnabled()){
        showDateFilterError("Custom date range is not available on this dashboard.");
        return;
      }
      if(!ds.s){
        showDateFilterError("Select the current period Start date first.");
        return;
      }
      if(!isDayBefore(dt, ds.s)){
        showDateFilterError("Comparison dates must be before the selected Start date.");
        return;
      }
      if(ds.pickingCmp==="s" || !ds.cs || (ds.cs && ds.ce && ds.pickingCmp==="s")){
        ds.cs=dt; ds.ce=null; ds.pickingCmp="e";
      } else if(dt<ds.cs){ ds.cs=dt; }
      else { ds.ce=dt; ds.pickingCmp=null; }
      clampCustomCompareToBeforeStart(ds);
      paintCalendar();
      return;
    }
    /* CXO: Custom disabled — calendar is view-only; presets set the range. Timesheet: pick Custom range. */
    if(!isDateFilterCustomEnabled()){
      return;
    }
    if(!ds.s || (ds.s && ds.e)){ ds.s=dt; ds.e=null; ds.pickingEnd=true; }
    else if(dt<ds.s){ ds.s=dt; ds.pickingEnd=true; }
    else { ds.e=dt; ds.pickingEnd=false; }
    ds.label="Custom";
    forceCustomPeriodFlag(ds, presets);
    /* Current Start moved — drop any Custom Comparison dates that now overlap. */
    clampCustomCompareToBeforeStart(ds);
    if(ds.cmp && ds.s && ds.e && !isCustomComparisonFlag(ds.comparisonName)) loadCompareRange(true);
    else paintCalendar();
  });

  gaS.onclick=function(){ ds.pickingEnd=false; ds.pickingCmp=null; paintCalendar(); };
  gaE.onclick=function(){ ds.pickingEnd=true; ds.pickingCmp=null; paintCalendar(); };
  if(gaCmpS){
    gaCmpS.onclick=function(){
      if(!ds.cmp || !isCustomComparisonFlag(ds.comparisonName)) return;
      if(!ds.s){
        showDateFilterError("Select the current period Start date first.");
        return;
      }
      ds.pickingCmp="s"; ds.pickingEnd=false; paintCalendar();
    };
  }
  if(gaCmpE){
    gaCmpE.onclick=function(){
      if(!ds.cmp || !isCustomComparisonFlag(ds.comparisonName)) return;
      if(!ds.s){
        showDateFilterError("Select the current period Start date first.");
        return;
      }
      ds.pickingCmp="e"; ds.pickingEnd=false; paintCalendar();
    };
  }
  pop.querySelector("#gaPrev").onclick=function(){
    ds.base=new Date(ds.base.getFullYear(), ds.base.getMonth()-1, 1);
    paintCalendar();
  };
  pop.querySelector("#gaNext").onclick=function(){
    ds.base=new Date(ds.base.getFullYear(), ds.base.getMonth()+1, 1);
    paintCalendar();
  };
  pop.querySelector("#gaCancel").onclick=closeDatePicker;
  pop.querySelector("#gaApply").onclick=function(){
    if(!isDateFilterCompareEnabled()){
      ds.cmp=false;
      ds.comparisonName="";
      ds.comparisonId=null;
      ds.pickingCmp=null;
      ds.cs=null;
      ds.ce=null;
    }
    if(!ds.e) ds.e=ds.s;
    if(ds.cmp && ds.cs && !ds.ce) ds.ce=ds.cs;
    const err=validateDateFilterApply(ds);
    if(err){ showDateFilterError(err); return; }

    function finishApply(){
      if(isTimesheetPage()) resetTimesheetDrill();
      syncDateFilterToState();
      closeDatePicker();
      if(typeof persistState==="function") persistState();
      /* CXO owns KPI refresh; other pages use renderPage. */
      if(typeof window.updateFilterHeader==="function"){
        try{ window.updateFilterHeader(); }catch(e){ /* ignore */ }
      }
      if(typeof window.RefreshKpiDashboard==="function"){
        window.RefreshKpiDashboard();
      }else if(typeof renderPage==="function"){
        renderPage();
      }
      toast("Period applied: "+formatFilterRangeSafe(DateFilter.startDate, DateFilter.endDate));
    }

    /* Timesheet Custom: resolve range via GetAnalyticsDBFilterDateRange (flag "0") before KPI */
    if(isTimesheetPage() && String(ds.label).toLowerCase()==="custom"){
      GetFilterDateRange("0", formatApiDate(ds.s), formatApiDate(ds.e), function(row){
        if(row && applyFilterDateRange(row, "Custom")){
          DateFilter.selectedFilterId=0;
          DateFilter.compare=!!ds.cmp;
          DateFilter.selectedComparisonName=ds.cmp?ds.comparisonName:"";
          DateFilter.selectedComparisonId=ds.cmp?ds.comparisonId:null;
          if(ds.cmp){
            DateFilter.previousStart=ds.cs;
            DateFilter.previousEnd=ds.ce;
          }
          finishApply();
          return;
        }
        DateFilter.selectedFilterId=0;
        DateFilter.selectedFilterName="Custom";
        DateFilter.startDate=ds.s;
        DateFilter.endDate=ds.e;
        DateFilter.compare=!!ds.cmp;
        DateFilter.selectedComparisonName=ds.cmp?ds.comparisonName:"";
        DateFilter.selectedComparisonId=ds.cmp?ds.comparisonId:null;
        if(ds.cmp && ds.cs && ds.ce){
          DateFilter.previousStart=ds.cs;
          DateFilter.previousEnd=ds.ce;
        }else{
          const computed=computeCompareRange(ds.s, ds.e, "prev");
          DateFilter.previousStart=computed[0];
          DateFilter.previousEnd=computed[1];
        }
        finishApply();
      });
      return;
    }

    if(String(ds.label).toLowerCase()==="custom"){
      const customOpt=findFilterOption("Custom", DateFilter.dateOptions);
      DateFilter.selectedFilterId=customOpt?Number(getFilterField(customOpt,"FilterID")):0;
    }else if(ds.filterId!=null){
      DateFilter.selectedFilterId=ds.filterId;
    }
    DateFilter.selectedFilterName=ds.label;
    DateFilter.startDate=ds.s;
    DateFilter.endDate=ds.e;
    DateFilter.compare=!!ds.cmp;
    DateFilter.selectedComparisonName=ds.cmp?ds.comparisonName:"";
    DateFilter.selectedComparisonId=ds.cmp?ds.comparisonId:null;
    /* Added by Dipali V. on 01-10-2026 — Custom: equal-length prior; Previous period: lastRange as-of. */
    if(isCustomPeriodFlag(ds.label)){
      if(ds.cmp && isCustomComparisonFlag(ds.comparisonName) && ds.cs && ds.ce){
        DateFilter.previousStart=ds.cs;
        DateFilter.previousEnd=ds.ce;
      }else{
        const customPrev=computePreviousPeriodEqualLength(ds.s, ds.e);
        DateFilter.previousStart=customPrev.start;
        DateFilter.previousEnd=customPrev.end;
        if(ds.cmp){
          ds.cs=customPrev.start;
          ds.ce=customPrev.end;
        }
      }
    }else if(ds.cmp && isAlignedPreviousPeriodComparison(ds.comparisonName) &&
        applyPreviousDatesFromRangeRow(ds, DateFilter.lastRange)){
      DateFilter.previousStart=ds.cs;
      DateFilter.previousEnd=ds.ce;
    }else if(ds.cmp && ds.cs && ds.ce){
      DateFilter.previousStart=ds.cs;
      DateFilter.previousEnd=ds.ce;
    }else if(DateFilter.lastRange){
      DateFilter.previousStart=parseFilterDate(getFilterField(DateFilter.lastRange,"PreviousStartDate"));
      DateFilter.previousEnd=parseFilterDate(getFilterField(DateFilter.lastRange,"PreviousEndDate"));
    }else if(ds.s && ds.e){
      const computed=computeCompareRange(ds.s, ds.e, "prev");
      DateFilter.previousStart=computed[0];
      DateFilter.previousEnd=computed[1];
    }else{
      DateFilter.previousStart=null;
      DateFilter.previousEnd=null;
    }
    finishApply();
  };

  paintCalendar();
  if(ds.cmp) loadCompareRange();
  setTimeout(function(){
    const onDoc=function(ev){
      if(pop.contains(ev.target) || (anchor && anchor.contains(ev.target))) return;
      closeDatePicker();
    };
    document.addEventListener("mousedown", onDoc, true);
    pop._onDocClose=onDoc;
  }, 0);
}
function formatFilterRangeSafe(s,e){
  if(!s||!e) return "";
  return rangeLbl(s,e);
}
function bindDatePickerButton(){
  const btn=document.getElementById("dateBtn");
  if(!btn) return;
  btn.onclick=function(e){
    e.preventDefault();
    e.stopPropagation();
    openDatePicker(e);
  };
}
/* Calendar UI + DateFilter shared with CXO aspx (SKIP_APP_JS_BOOT). Added by Dipali V. on 01-10-2026. */
window.DateFilter=DateFilter;
window.openDatePicker=openDatePicker;
window.closeDatePicker=closeDatePicker;
window.isDateFilterCustomEnabled=isDateFilterCustomEnabled;
window.isDateFilterCompareEnabled=isDateFilterCompareEnabled;
window.bindDatePickerButton=bindDatePickerButton;
if(!window.SKIP_APP_JS_BOOT){
  bindDatePickerButton();
}
function syncDateUI(){
  const lbl=$("#dateLabel"), rng=$("#dateRangeTxt"), tag=$("#compareTag");
  if(lbl) lbl.textContent=state.date.label;
  if(rng) rng.textContent=state.date.range;
  const compareOn=!!(DateFilter.compare||state.date.compare);
  if(document.body) document.body.classList.toggle("ts-compare-off", isTimesheetPage() && !compareOn);
  if(tag){
    if(isTimesheetPage() && !compareOn){
      tag.style.display="none";
      tag.hidden=true;
      tag.textContent="";
    }else{
      tag.style.display="";
      tag.hidden=false;
      if(typeof window.tsCompareTagText==="function"){
        tag.textContent=window.tsCompareTagText(DateFilter.selectedComparisonName||state.date.comparisonName||"", state.date.compareMode||"prev");
      }else{
        const name=String(DateFilter.selectedComparisonName||state.date.comparisonName||"").replace(/^vs\s+/i,"").trim();
        tag.textContent=name?("vs "+name):compareTagText(state.date.compareMode||"prev");
      }
    }
  }
}
if(!window.SKIP_APP_JS_BOOT){
const clearFiltersEl=$("#clearFilters");
if(clearFiltersEl) clearFiltersEl.onclick=()=>{
  Object.keys(state.filters).forEach(k=>state.filters[k]=[]);
  clearTopFilterSelections();
  if(isTimesheetPage()) resetTimesheetDrill();
  const afterClear=function(){
    renderChips();renderPage();persistState();toast("All filters cleared");
  };
  if(isTimesheetPage()) reloadTimesheetProjectManagers(afterClear);
  else afterClear();
};
}

/* drill trail */
function setTrail(path){
  state.trail=path;
  const trailEl=$("#trail");
  if(!trailEl) return;
  trailEl.innerHTML=`<span class="trail-label">Drill trail</span>`+
    (path.length?path.map((p,i)=>`${i?'<span class="sep">›</span>':""}<button class="t-chip" onclick="trailJump(${i})">${esc(p.label)}</button>`).join(""):`<span class="t-chip" style="cursor:default;color:var(--faint)">Click any KPI or chart to start a cross-module drill-through →</span>`);
}
function trailJump(i){ if(state.trail[i]) drillTo(state.trail[i].type, state.trail.slice(0,i+1)); }

/* =====================================================================
   CHART HELPERS
===================================================================== */
function css(v){return getComputedStyle(document.documentElement).getPropertyValue(v).trim();}
function baseOpts(extra={}){
  return Object.assign({responsive:true,maintainAspectRatio:false,
    plugins:{legend:{labels:{color:css("--chart-tick"),boxWidth:10,boxHeight:10,usePointStyle:true,font:{size:11}}},
      tooltip:{backgroundColor:css("--surface-solid"),borderColor:css("--border-strong"),borderWidth:1,titleColor:css("--text"),bodyColor:css("--muted"),padding:10,cornerRadius:10}},
    scales:{x:{ticks:{color:css("--chart-tick"),font:{size:10.5}},grid:{color:"transparent"}},
            y:{ticks:{color:css("--chart-tick"),font:{size:10.5}},grid:{color:css("--grid-line")}}},
    onClick:(e,els,c)=>{if(els.length&&c.canvas.dataset.drill)drill(c.canvas.dataset.drill);}
  },extra);
}
function mkChart(id,cfg,drillType){
  const el=document.getElementById(id); if(!el)return;
  if(state.charts[id])state.charts[id].destroy();
  if(drillType)el.dataset.drill=drillType;
  state.charts[id]=new Chart(el,cfg);
}
function months(){ const m=state.date.months; const n=m>=11?12:m>=5?6:m>=2.7?3:2; return MONTHS.slice(-n); }
function trendSlice(arr){ const n=months().length; const s=fp().length/PROJECTS.length||1; return arr.slice(-n).map(v=>Math.round(v*s)); }

/* =====================================================================
   PAGE RENDERERS
===================================================================== */
/* =====================================================================
   PROJECT HOURS REPORT (preview.html)
===================================================================== */
function hoursFmt(v,d=1){return Number(v).toLocaleString(undefined,{minimumFractionDigits:0,maximumFractionDigits:d})}
function hoursRange(){return Array.from({length:hoursState.to-hoursState.from+1},(_,i)=>hoursState.from+i)}
function hoursSum(a){return a.reduce((x,y)=>x+(Number(y)||0),0)}
function hoursTotals(p){
  const ix=hoursRange(),target=hoursSum(ix.map(i=>p.target[i])),actual=hoursSum(ix.map(i=>p.actual[i]));
  return {target,actual,variance:actual-target,performance:target?actual/target*100:null};
}
function hoursVisible(){
  const q=hoursState.filterSearch.trim().toLowerCase();
  return HOUR_PROJECTS.filter((p,i)=>(hoursState.project==="all"||String(i)===String(hoursState.project))&&(!q||p.name.toLowerCase().includes(q))&&(!hoursState.hideZero||hoursTotals(p).target||hoursTotals(p).actual));
}
function hoursAggregate(){
  const ps=hoursVisible(),ix=hoursRange();
  return {target:ix.map(i=>hoursSum(ps.map(p=>p.target[i]))),actual:ix.map(i=>hoursSum(ps.map(p=>p.actual[i])))};
}
function hoursStatus(t){
  if(!t.target&&!t.actual)return ["No activity","mut"];
  if(t.target&&!t.actual)return ["No actual","risk"];
  if(t.performance>110)return ["Above target","risk"];
  if(t.performance<80)return ["Below target","risk"];
  if(t.performance<95)return ["Watch","warn"];
  return ["On target","good"];
}
function hoursTableData(){
  let rows=HOUR_PROJECTS.map((p,i)=>({i,name:p.name,...hoursTotals(p)}));
  const q=hoursState.tableSearch.trim().toLowerCase(); if(q)rows=rows.filter(r=>r.name.toLowerCase().includes(q));
  if(hoursState.exception==="above")rows=rows.filter(r=>r.performance>110);
  if(hoursState.exception==="below")rows=rows.filter(r=>r.target&&r.performance<80);
  if(hoursState.exception==="noActual")rows=rows.filter(r=>r.target&&!r.actual);
  if(hoursState.exception==="inactive")rows=rows.filter(r=>!r.target&&!r.actual);
  if(hoursState.hideZero)rows=rows.filter(r=>r.target||r.actual);
  rows.sort((a,b)=>{
    if(hoursState.sort==="status"){
      const as=hoursStatus(a)[0],bs=hoursStatus(b)[0];
      return as.localeCompare(bs)*hoursState.dir;
    }
    let x=a[hoursState.sort],y=b[hoursState.sort];
    if(typeof x==="string")return x.localeCompare(y)*hoursState.dir;
    return ((x??-Infinity)-(y??-Infinity))*hoursState.dir;
  });
  return rows;
}
function hoursRefresh(focusId){
  if(state.page!=="preview") return;
  const active=document.activeElement;
  const id=focusId||(active&&active.id&&(active.id==="hrFilterSearch"||active.id==="hrTableSearch")?active.id:null);
  const start=active&&typeof active.selectionStart==="number"?active.selectionStart:null;
  const end=active&&typeof active.selectionEnd==="number"?active.selectionEnd:null;
  renderPage();
  if(id){
    const el=document.getElementById(id);
    if(el){el.focus(); if(start!==null) try{el.setSelectionRange(start,end)}catch(e){}}
  }
}
function bindHoursUI(){
  if(state.page!=="preview"||!$("#hrFrom")) return;
  const sync=()=>{
    hoursState.from=+$("#hrFrom").value; hoursState.to=+$("#hrTo").value;
    hoursState.project=$("#hrProject").value; hoursState.metric=$("#hrMetric").value;
    hoursState.axisMode=$("#hrAxis").value; hoursState.filterSearch=$("#hrFilterSearch").value;
    hoursState.hideZero=$("#hrHideZero").checked; hoursRefresh();
  };
  $("#hrFrom").onchange=sync; $("#hrTo").onchange=sync; $("#hrProject").onchange=()=>{hoursState.exception=null;sync()};
  $("#hrMetric").onchange=sync; $("#hrAxis").onchange=sync;
  $("#hrFilterSearch").oninput=e=>{hoursState.filterSearch=e.target.value;hoursRefresh()};
  $("#hrHideZero").onchange=sync;
  $("#hrTableSearch")&&($("#hrTableSearch").oninput=e=>{hoursState.tableSearch=e.target.value;hoursRefresh()});
  $$("[data-hr-range]").forEach(b=>b.onclick=()=>{
    const map={ytd:[0,6],q1:[0,2],q2:[3,5],q3:[6,8],q4:[9,11],year:[0,11]};
    hoursState.rangeChip=b.dataset.hrRange; [hoursState.from,hoursState.to]=map[b.dataset.hrRange]; hoursRefresh();
  });
  $$("[data-hr-view]").forEach(b=>b.onclick=()=>{hoursState.view=b.dataset.hrView;hoursRefresh()});
  $$("[data-hr-ex]").forEach(el=>el.onclick=()=>{
    const next=hoursState.exception===el.dataset.hrEx?null:el.dataset.hrEx;
    hoursState.exception=next;
    hoursRefresh();
    if(next) drill("hours");
  });
  $$("#hrTable th[data-hr-sort]").forEach(th=>th.onclick=()=>{
    const s=th.dataset.hrSort;
    if(hoursState.sort===s) hoursState.dir*=-1; else {hoursState.sort=s;hoursState.dir=s==="name"?1:-1}
    hoursRefresh();
  });
  $$("#hrTable tbody tr[data-hr-i]").forEach(tr=>tr.onclick=()=>{
    drillHoursProject(tr.dataset.hrI);
    hoursRefresh();
  });
  $("#hrReset").onclick=()=>{
    Object.assign(hoursState,{from:0,to:11,project:"all",metric:"hours",view:"line",sort:"actual",dir:-1,exception:null,hideZero:true,filterSearch:"",tableSearch:"",axisMode:"auto",rangeChip:"year"});
    hoursRefresh();
  };
  $("#hrCsvBtn").onclick=()=>{
    const rows=hoursTableData();
    const csv=[["Project","Target","Actual","Variance","Actual / Target %"],...rows.map(r=>[r.name,r.target,r.actual,r.variance,r.performance??""])]
      .map(r=>r.map(v=>`"${String(v).replaceAll('"','""')}"`).join(",")).join("\n");
    downloadCSV(csv,`project-hours-${HR_MONTHS[hoursState.from]}-${HR_MONTHS[hoursState.to]}-2026.csv`);
  };
}
function drawHoursChart(){
  if(!$("#chHours")) return;
  const acc=css("--accent"),warn=css("--warn"),mut=css("--chart-tick");
  const agg=hoursAggregate(),ix=hoursRange(),labels=ix.map(i=>HR_MONTHS[i]);
  let A=[...agg.target],B=[...agg.actual];
  if(hoursState.view==="cumulative"){A=A.map((_,i)=>hoursSum(A.slice(0,i+1)));B=B.map((_,i)=>hoursSum(B.slice(0,i+1)))}
  let datasets=[],zeroLine=false,yFixed=false;
  if(hoursState.metric==="hours"){
    datasets=[
      {label:"Target",data:A,borderColor:acc,backgroundColor:"rgba(71,158,245,.18)",tension:.35,pointRadius:3,fill:hoursState.view!=="bar"},
      {label:"Actual",data:B,borderColor:warn,backgroundColor:"rgba(234,163,0,.22)",tension:.35,pointRadius:3,fill:false}
    ];
    yFixed=hoursState.axisMode==="fixed";
  } else if(hoursState.metric==="variance"){
    datasets=[{label:"Variance",data:B.map((v,i)=>v-A[i]),borderColor:warn,backgroundColor:warn,tension:.35,pointRadius:3}];
    zeroLine=true;
  } else if(hoursState.metric==="variancePct"){
    datasets=[{label:"Variance %",data:B.map((v,i)=>A[i]?((v-A[i])/A[i])*100:0),borderColor:warn,backgroundColor:warn,tension:.35,pointRadius:3}];
    zeroLine=true;
  } else {
    datasets=[{label:"Actual / Target %",data:B.map((v,i)=>A[i]?v/A[i]*100:0),borderColor:acc,backgroundColor:acc,tension:.35,pointRadius:3}];
  }
  const useBar=hoursState.view==="bar"||hoursState.metric!=="hours";
  datasets=datasets.map(d=>({...d,type:useBar?"bar":"line",borderRadius:useBar?6:0,borderWidth:useBar?0:2.4}));
  const opts=baseOpts();
  if(yFixed){opts.scales.y.min=0;opts.scales.y.max=1000}
  if(zeroLine){opts.scales.y={...opts.scales.y,grace:"8%"}}
  mkChart("chHours",{type:useBar?"bar":"line",data:{labels,datasets},options:opts},"hours");
  const leg=$("#hrLegend"); if(leg) leg.innerHTML=datasets.map(s=>`<span><i style="background:${s.borderColor||s.backgroundColor}"></i>${s.label}</span>`).join("");
  const note=$("#hrAxisNote"); if(note) note.textContent=`Y-axis ${hoursState.axisMode==="auto"?"automatically scaled":"fixed at 0–1,000 hours"} · ${hoursState.view==="cumulative"?"Cumulative":"Period"} view · click chart to drill`;
}

function aiInsightsUnderConstructionSlideHtml(){
  return `<div class="ai-under-construction" role="status">
    <div class="ai-uc-mascot" aria-hidden="true">
      <div class="ai-uc-hat"></div>
      <div class="ai-uc-face">
        <div class="ai-uc-eye"><span class="ai-uc-lid"></span><span class="ai-uc-pupil"></span></div>
        <div class="ai-uc-eye"><span class="ai-uc-lid"></span><span class="ai-uc-pupil"></span></div>
      </div>
    </div>
    <div class="ai-uc-title">Under Construction</div>
    <div class="ai-uc-sub">This section will be available shortly.</div>
    <div class="ai-uc-tape" aria-hidden="true"></div>
  </div>`;
}
function aiInsightsExecContentHtml(a){
  a=a||agg();
  return `<div class="ai-item"><div class="ai-ic b-risk"><i class="fas fa-exclamation"></i></div><div><b>Delay prediction:</b> Core Banking Modernization has an <b>81% probability</b> of missing the Sep-20 go-live. Driver: UAT defect inflow 2.3x plan. <div class="conf">Confidence 81% · features: velocity, defect arrival rate, dependency slippage</div></div></div>
    <div class="ai-item"><div class="ai-ic b-warn"><i class="fas fa-rupee-sign"></i></div><div><b>Budget overrun:</b> Wealth Advisory Platform will exceed budget by <b>Rs 64 L (11.4%)</b> at current burn. Suggest converting CR-118 to billable scope. <div class="conf">Confidence 88% · Monte-Carlo P70 on burn rate</div></div></div>
    <div class="ai-item"><div class="ai-ic b-good"><i class="fas fa-magic"></i></div><div><b>Intelligent staffing:</b> Redeploying Farhan Q. and Sameer J. from bench to Fraud Analytics lifts Q2 utilization to <b>89.4%</b> and adds <b>Rs 38 L</b> revenue.</div></div>
    <div class="ai-item"><div class="ai-ic b-info"><i class="fas fa-info"></i></div><div><b>Anomaly:</b> UrbanKart non-billable hours spiked <b>+34%</b> in Jun - 68% logged against "solutioning". Pattern resembles pre-sales leakage.</div></div>
    <div class="ai-item"><div class="ai-ic b-warn"><i class="fas fa-user-clock"></i></div><div><b>Attrition risk:</b> 3 resources on Payments Switch show elevated attrition signals (overtime + skipped leave + comp band). Backfill lead time ~7 weeks.</div></div>
    <div class="ai-item"><div class="ai-ic b-good"><i class="fas fa-chart-line"></i></div><div><b>Revenue forecast:</b> Q2 FY27 projected at <b>${cr(a.rev*1.07)}</b> (P50), range ${cr(a.rev*0.98)}-${cr(a.rev*1.15)}. Upside tied to Vega MES Phase-2 (Rs 2.1 Cr, 74% win probability).</div></div>`;
}
function aiInsightsExecSlidesHtml(a){
  return `<div class="ai-uc-deck">
    <div class="ai-uc-track">
      <div class="ai-uc-slide ai-uc-slide-content">${aiInsightsExecContentHtml(a)}</div>
      <div class="ai-uc-slide ai-uc-slide-hold">${aiInsightsUnderConstructionSlideHtml()}</div>
    </div>
    <div class="ai-uc-dots" aria-hidden="true"><span></span><span></span></div>
  </div>`;
}
/* Copilot UC slides HTML is owned by Resource_Timesheet_Dash / CXO aspx pages. */
function fillCopilotUcSlides(){
  if(typeof window.tsFillCopilotUcSlides==="function"){
    window.tsFillCopilotUcSlides();
    return;
  }
  const body=document.querySelector("#copilot .cp-uc-body");
  if(!body) return;
  if(typeof aiInsightsExecSlidesHtml==="function"){
    let a=null;
    try{ if(typeof agg==="function") a=agg(); }catch(err){}
    body.innerHTML=aiInsightsExecSlidesHtml(a);
  }
}
function openCopilot(seed){
  const cp=$("#copilot");
  if(cp) cp.classList.add("open");
  if(typeof window.tsOpenCopilot==="function"){
    window.tsOpenCopilot(seed);
    return;
  }
  fillCopilotUcSlides();
}

function getTimeOfDayGreeting(){
  const h=new Date().getHours();
  if(h>=5 && h<12) return "Good morning";
  if(h>=12 && h<17) return "Good afternoon";
  return "Good evening";
}
/* Same CXO dashboard as PM_AnalyticsCXO_Dashboard.aspx (HighLevelRole + greeting SP). */
function getCxoGreetingDashboardId(){
  if(typeof window!=="undefined" && window.CXO_GREETING_DASHBOARD_ID!=null){
    const n=Number(window.CXO_GREETING_DASHBOARD_ID);
    if(isFinite(n) && n>0) return n;
  }
  return 21036;
}
const TimesheetGreet={ employeeName:"", roleId:null, roleName:"", loaded:false };
/* Purpose: Headline — Good morning, {EmployeeName} 👋  (same as CXO buildGreetingHeadline). */
function buildTimesheetGreetingHeadline(){
  const name=String(TimesheetGreet.employeeName||"").trim();
  const prefix=getTimeOfDayGreeting();
  if(name) return prefix+", "+name+" \uD83D\uDC4B";
  return prefix;
}
function applyTimesheetGreetingToDom(){
  const host=document.getElementById("page-timesheets");
  const h1=(host&&host.querySelector(".exec-greet h1"))||document.getElementById("greet");
  if(h1) h1.textContent=buildTimesheetGreetingHeadline();
}
function unwrapRoleGreetingRow(json){
  const rows=getApiRows(json);
  if(rows && rows.length) return rows[0];
  let node=json, depth=0;
  while(node && typeof node==="object" && !Array.isArray(node) && depth<6){
    if(getFilterField(node,"EmployeeName")) return node;
    if(node.data!=null && typeof node.data==="object"){ node=node.data; depth++; continue; }
    if(node.Data!=null && typeof node.Data==="object"){ node=node.Data; depth++; continue; }
    break;
  }
  return null;
}
function normalizeHighLevelRoleRows(rows){
  const list=[];
  (rows||[]).forEach(function(row){
    const id=getFilterField(row,"ID","Id","id","RoleID","Value","FilterID","ItemID");
    const name=getFilterField(row,"Name","name","RoleName","Text","FilterName");
    if(id==null || name==null || name==="") return;
    list.push({id:String(id), name:String(name)});
  });
  return list;
}
function extractHighLevelRolesFromBag(bag){
  bag=bag||{};
  const key=Object.keys(bag).find(function(k){
    return String(k).replace(/\s/g,"").toLowerCase()==="highlevelrole";
  });
  let rows=key?bag[key]:[];
  if(!Array.isArray(rows)) rows=getApiRows(rows);
  return normalizeHighLevelRoleRows(rows);
}
/* Purpose: Same as CXO LoadRoleGreeting — RoleID + Session UserID → EmployeeName. */
function loadTimesheetRoleGreeting(onDone){
  if(!canUseFilterApis() || !isTimesheetPage()){
    if(onDone) onDone(null);
    return;
  }
  const dash=getCxoGreetingDashboardId();
  const finish=function(){
    TimesheetGreet.loaded=true;
    applyTimesheetGreetingToDom();
    if(onDone) onDone(TimesheetGreet.employeeName||null);
  };
  const callGreeting=function(roleId){
    if(!roleId){ TimesheetGreet.employeeName=""; finish(); return; }
    TimesheetGreet.roleId=roleId;
    callFilterDashboardApi("GetAnalyticsDBRoleGreeting", {
      DashboardID:dash,
      RoleID:Number(roleId)||0,
      UserID:(typeof SessionEmployeeID!=="undefined"?SessionEmployeeID:"")||""
    }, function(json){
      const row=unwrapRoleGreetingRow(json);
      TimesheetGreet.employeeName=row?String(getFilterField(row,"EmployeeName")||"").trim():"";
      finish();
    }, function(){
      TimesheetGreet.employeeName="";
      finish();
    });
  };
  if(TimesheetGreet.roleId){ callGreeting(TimesheetGreet.roleId); return; }
  callFilterDashboardApi("GetAnalyticsDBFilterFlagWise", {
    DashboardID:dash,
    Flag:"HighLevelRole"
  }, function(json){
    let roles=extractHighLevelRolesFromBag(getApiDataBag(json)||{});
    if(!roles.length){
      let node=json, depth=0;
      while(node && typeof node==="object" && depth<6){
        roles=extractHighLevelRolesFromBag(node);
        if(roles.length) break;
        /* Single-flag responses sometimes return the role rows as a bare array. */
        if(Array.isArray(node)){ roles=normalizeHighLevelRoleRows(node); break; }
        const nested=node.data!=null?node.data:(node.Data!=null?node.Data:null);
        if(nested==null) break;
        node=nested;
        depth++;
      }
    }
    if(!roles.length){
      roles=normalizeHighLevelRoleRows(getApiRows(json));
    }
    if(!roles.length){ callGreeting(null); return; }
    TimesheetGreet.roleName=roles[0].name;
    callGreeting(roles[0].id);
  }, function(){ callGreeting(null); });
}

const PAGES={
exec(){
  const a=agg();
  const roleKey=($("#roleSel")&&$("#roleSel").value)||"ceo";
  const roleGreet=(typeof ROLES!=="undefined" && ROLES[roleKey] && ROLES[roleKey].greet) || "Good morning, Vishwas 👋";
  return `
  <div class="cxo-toolbar">
    <div class="exec-greet">
      <h1 id="greet">${roleGreet}</h1>
      <p id="greetSub">CXO Dashboard · ${state.date.label} · consolidated across <b>${a.P.length}</b> projects, <b>${new Set(a.P.map(p=>p.portfolio)).size}</b> portfolios, <b>${new Set(a.P.map(p=>p.customer)).size}</b> customers</p>
    </div>
    <div class="hd-actions">
      <button class="ghostbtn" type="button" onclick="drill('revenue')"><i class="fas fa-level-down-alt"></i> Drill revenue</button>
      <button class="ghostbtn" type="button" onclick="shareMenu(event)" title="Export / share / schedule"><i class="fas fa-share-alt"></i> Export / Share</button>
      <button class="ghostbtn" type="button" onclick="openCopilot()">${copilotBtnIcon()} Copilot</button>
    </div>
  </div>
  <div class="exec-base-note" role="note">
    <i class="fas fa-exclamation-triangle" aria-hidden="true"></i>
    <span><b class="note-label">Note</b> All dashboard values are displayed in the configured <b>Base Currency</b>. Revenue, Gross Profit, Gross Margin, EBIT, and Net Profit are based on the <b>latest available Profitability snapshot</b>. If any mismatch is observed, please generate the latest Profitability snapshot and verify the dashboard values.</span>
  </div>

  <div class="grid kpi-grid">
    ${kpiCard({label:"Revenue",value:cr(a.rev),delta:0,drill:"revenue"})}
    ${kpiCard({label:"Gross Profit",value:cr(a.gp),delta:0,color:"var(--good)",drill:"revenue"})}
    ${kpiCard({label:"Gross Margin",value:pct(a.margin),delta:0,goodUp:true,drill:"revenue"})}
    ${kpiCard({label:"EBIT",value:cr(a.ebit),delta:0,drill:"revenue"})}
    ${kpiCard({label:"Net Profit",value:cr(a.np),delta:0,drill:"revenue"})}
    ${kpiCard({label:"Resource Utilization",value:pct(a.util),delta:0,color:"var(--good)",drill:"util"})}
    ${kpiCard({label:"Bench",value:a.bench+" <small>FTE</small>",delta:0,goodUp:false,drill:"util"})}
    ${kpiCard({label:"Active Projects",value:a.active,delta:0,drill:"projects"})}
    ${kpiCard({label:"Delayed Projects",value:a.delayed,delta:0,goodUp:false,drill:"projects"})}
    ${kpiCard({label:"Budget Variance",value:pct(a.bvar),delta:0,goodUp:false,drill:"projects"})}
    ${kpiCard({label:"Customer CSAT",value:a.csat.toFixed(2)+" <small>/ 5</small>",delta:0,drill:"projects"})}
  </div>

  <div class="grid g2 mt">
    ${widget("Revenue vs Cost - trend & forecast","Actuals · dotted = AI forecast (P50) · shaded = compare period",`<div class="chartbox"><canvas id="chRev"></canvas></div>`,{drill:"revenue"})}
    ${widget("Portfolio revenue mix","Click a slice to drill into that portfolio",`<div class="chartbox doughnut-box"><canvas id="chMix"></canvas><div class="doughnut-center" id="chMixCenter"><span class="doughnut-center-label">Total</span><span class="doughnut-center-value"></span></div></div>`,{drill:"revenue"})}
  </div>

  <div class="grid g2 mt">
    <div class="ai-panel" id="aiInsightsExec">
      <div class="ai-hd"><span class="pulse"></span> AI Insights &amp; Recommended Actions <span class="badge b-info" style="margin-left:auto">6 new</span></div>
      <div class="ai-panel-body">
        ${aiInsightsExecSlidesHtml(a)}
      </div>
    </div>
    ${widget("Cost & budget variance by project","Bars beyond 100% burn are flagged · click to drill to spend lines",`<div class="chartbox"><canvas id="chVar"></canvas></div>`,{drill:"projects"})}
  </div>`;
},

projects(){
  const a=agg();
  const rows=a.P.map(p=>`<tr onclick="drillProject('${p.id}')">
    <td><b>${p.name}</b><div style="font-size:10.5px;color:var(--faint)">${p.id} · ${p.customer}</div></td>
    <td><span class="badge b-mut">${p.portfolio}</span></td><td>${p.pm}</td>
    <td>${healthBadge(p.health)}</td>
    <td class="num">${p.spi.toFixed(2)}</td><td class="num">${p.cpi.toFixed(2)}</td>
    <td><div class="pbar"><i style="width:${Math.min(p.spent/p.budget*100,100)}%;background:${p.spent>p.budget?"var(--risk)":p.spent/p.budget>.85?"var(--warn)":"var(--good)"}"></i></div><div style="font-size:10px;color:var(--faint);margin-top:3px">${cr(p.spent)} / ${cr(p.budget)}</div></td>
    <td>${p.delayDays?`<span class="badge b-${p.delayDays>20?"risk":"warn"}">${p.delayDays}d late</span>`:'<span class="badge b-good">on time</span>'}</td>
    <td><span class="badge b-${p.risk==="Low"?"good":p.risk==="Medium"?"warn":"risk"}">${p.risk}</span></td></tr>`).join("");
  return `
  <div class="page-hd"><div><h1>Projects & Portfolio Governance</h1><p>${a.P.length} projects in scope${a.P.length?` · SPI ${(a.P.reduce((x,p)=>x+p.spi,0)/a.P.length).toFixed(2)} · CPI ${(a.P.reduce((x,p)=>x+p.cpi,0)/a.P.length).toFixed(2)}`:""} · earned-value method: % complete</p></div>
  <div class="hd-actions"><button class="ghostbtn" onclick="openGantt()">📊 Gantt / Critical path</button><button class="ghostbtn" onclick="toast('Gate reviews')">Gate reviews</button><button class="ghostbtn" type="button" onclick="shareMenu(event)" title="Export / share / schedule"><i class="fas fa-share-alt"></i> Export / Share</button><button class="ghostbtn" type="button" onclick="openCopilot()">${copilotBtnIcon()} Copilot</button></div></div>
  <div class="grid g2">
    ${(()=>{const P=a.P;const spi=P.length?P.reduce((x,p)=>x+p.spi,0)/P.length:0,cpi=P.length?P.reduce((x,p)=>x+p.cpi,0)/P.length:0;
      const tile=(l,v,note,cls)=>`<div style="flex:1;min-width:150px;background:var(--surface-2);border:1px solid var(--border);border-radius:10px;padding:10px 13px">
        <div style="font-size:10px;letter-spacing:.09em;text-transform:uppercase;color:var(--muted);font-weight:600">${l}</div>
        <div style="display:flex;align-items:baseline;gap:8px;margin-top:3px"><span class="num" style="font-size:21px;font-weight:700">${v}</span><span class="badge b-${cls}">${note}</span></div>
        <div class="pbar" style="margin-top:8px"><i style="width:${Math.min(parseFloat(v)*100/1.2,100)}%;background:var(--${cls==="good"?"good":cls==="warn"?"warn":"risk"})"></i></div>
        <div style="font-size:10px;color:var(--faint);margin-top:4px">Target 1.00</div></div>`;
      return widget("Schedule & cost performance (EVM)","How far each project is ahead of or behind plan · target = 0% · bars left of centre need attention",
      `<div style="display:flex;gap:10px;flex-wrap:wrap;margin-bottom:12px">
         ${tile("Portfolio SPI · schedule",spi.toFixed(2),spi>=1?"On plan":spi>=0.9?"Slightly behind":"Behind","warn")}
         ${tile("Portfolio CPI · cost",cpi.toFixed(2),cpi>=1?"Under budget":cpi>=0.95?"Near plan":"Over budget","good")}
         <div style="flex:1;min-width:150px;background:var(--surface-2);border:1px solid var(--border);border-radius:10px;padding:10px 13px">
           <div style="font-size:10px;letter-spacing:.09em;text-transform:uppercase;color:var(--muted);font-weight:600">AI portfolio health</div>
           <div style="display:flex;align-items:baseline;gap:8px;margin-top:3px"><span class="num" style="font-size:21px;font-weight:700">—</span></div>
           <div class="pbar" style="margin-top:8px"><i style="width:0;background:var(--accent)"></i></div>
           <div style="font-size:10px;color:var(--faint);margin-top:4px">Weighted on SPI · CPI · risk · CSAT</div></div>
       </div>
       <div class="chartbox" style="height:330px"><canvas id="chEVM"></canvas></div>
       <div class="legend"><span><i style="background:#479EF5"></i>Schedule vs plan (SPI)</span><span><i style="background:#9373C0"></i>Cost vs plan (CPI)</span><span style="color:var(--faint)">← behind plan &nbsp;·&nbsp; 0 = on target &nbsp;·&nbsp; ahead of plan →</span></div>`,
      {drill:"projects"});})()}
    ${widget("Open risks & issues","Top exposure · RAID log",`<div class="m-note">No rows for this selection.</div>`)}
  </div>
  <div class="mt">${widget("Portfolio health grid","Click any project → milestones → tasks → timesheets → audit trail (full drill path) · scroll for more rows",
    `<div class="scroll-x grid-scroll"><table class="tbl"><thead><tr><th>Project ▾</th><th>Portfolio</th><th>PM</th><th>Health</th><th>SPI</th><th>CPI</th><th>Budget burn</th><th>Schedule</th><th>Risk</th></tr></thead><tbody>${rows}</tbody></table></div>`)}</div>
  <div class="grid g3 mt">
    ${widget("Milestones — next 60 days","Cross-portfolio · click a project row to drill",`
      <div class="milelist">${a.P.flatMap(p=>p.milestones.map(m=>({p,m}))).slice(0,6).map(({p,m})=>
        `<div class="mile"><span class="md" style="background:${m[2]==="On track"?"var(--good)":m[2]==="At risk"?"var(--warn)":"var(--risk)"}"></span>
         <div><b>${m[0]}</b> · ${m[1]}<small>${p.name} · ${m[2]}</small></div></div>`).join("")}
      </div>`)}
    ${widget("Earned value — planned vs earned vs actual","Cumulative, portfolio roll-up",`<div class="chartbox sm"><canvas id="chEV"></canvas></div>`)}
    ${widget("Change requests & dependencies","Change request pipeline",`<div class="chartbox sm"><canvas id="chCR"></canvas></div>`)}
  </div>`;
},

resources(){
  const shades=v=>v>=90?"var(--good)":v>=75?"rgba(84,176,84,.42)":v>=60?"var(--warn-soft)":"var(--risk-soft)";
  const heat=RESOURCES.map(r=>`<div class="hn" title="${r[0]} · ${r[1]}">${r[0]}</div>`+
    r[3].map((v,i)=>`<div class="hc" style="background:${shades(v)};color:${v>=75?"#0B2B0B":"var(--text)"}" onclick="drill('util')" title="${r[0]} · Wk-${i+1}: ${v}% billable">${v}</div>`).join("")).join("");
  return `
  <div class="page-hd"><div><h1>Resource Command Center</h1><p>Resource utilization, capacity and bench</p></div>
  <div class="hd-actions"><button class="ghostbtn" onclick="toast('Allocation calendar')">📆 Allocation calendar</button><button class="ghostbtn" onclick="openCopilot()">✦ AI staffing</button><button class="ghostbtn" type="button" onclick="shareMenu(event)" title="Export / share / schedule"><i class="fas fa-share-alt"></i> Export / Share</button></div></div>
  <div class="grid kpi-grid">
    ${kpiCard({label:"Utilization (billable)",value:pct(agg().util),delta:0,color:"var(--good)",drill:"util"})}
    ${kpiCard({label:"Availability next 30d",value:"—",delta:0,drill:"util"})}
    ${kpiCard({label:"Capacity vs demand",value:"—",delta:0,goodUp:false,drill:"util"})}
    ${kpiCard({label:"Bench",value:agg().bench+" <small>FTE</small>",delta:0,goodUp:false,drill:"util"})}
    ${kpiCard({label:"Certifications expiring 90d",value:"—",delta:0,goodUp:false})}
    ${kpiCard({label:"Attrition risk (AI)",value:"—",delta:0,goodUp:false})}
  </div>
  <div class="grid g2 mt">
    ${widget("Utilization heat map — last 6 weeks","% billable per resource · hover for detail, click to drill to timesheets",
      `<div class="heat"><div></div>${[1,2,3,4,5,6].map(i=>`<div class="hh">Wk-${i}</div>`).join("")}${heat}</div>
       <div class="legend"><span><i style="background:var(--good)"></i>≥90 optimal</span><span><i style="background:rgba(84,176,84,.42)"></i>75–89 healthy</span><span><i style="background:var(--warn-soft)"></i>60–74 soft</span><span><i style="background:var(--risk-soft)"></i>&lt;60 bench risk</span></div>`,{drill:"util"})}
    <div class="grid" style="gap:14px">
      ${widget("Demand vs capacity by skill","Next quarter · FTE",`<div class="chartbox sm"><canvas id="chCap"></canvas></div>`)}
      ${widget("Skill distribution","Headcount by practice",`<div class="chartbox sm"><canvas id="chSkill"></canvas></div>`)}
    </div>
  </div>
  <div class="mt">
    <div class="ai-panel" id="aiInsightsResources"><div class="ai-hd"><span class="pulse"></span> AI resource recommendations</div>
      <div class="ai-under-construction" role="status">
        <div class="ai-uc-mascot" aria-hidden="true">
          <div class="ai-uc-hat"></div>
          <div class="ai-uc-face">
            <div class="ai-uc-eye"><span class="ai-uc-lid"></span><span class="ai-uc-pupil"></span></div>
            <div class="ai-uc-eye"><span class="ai-uc-lid"></span><span class="ai-uc-pupil"></span></div>
          </div>
        </div>
        <div class="ai-uc-slider">
          <div class="ai-uc-track">
            <div class="ai-uc-slide">
              <div class="ai-uc-title">Under Construction</div>
              <div class="ai-uc-sub">This section will be available shortly.</div>
            </div>
            <div class="ai-uc-slide">
              <div class="ai-uc-title">Coming Soon</div>
              <div class="ai-uc-sub">AI Insights &amp; Recommended Actions will appear here.</div>
            </div>
            <div class="ai-uc-slide">
              <div class="ai-uc-title">Almost Ready</div>
              <div class="ai-uc-sub">Please check back shortly for live recommendations.</div>
            </div>
          </div>
        </div>
        <div class="ai-uc-dots" aria-hidden="true"><span></span><span></span><span></span></div>
        <div class="ai-uc-tape" aria-hidden="true"></div>
      </div>
    </div>
  </div>`;
},

finance(){
  const a=agg();
  const inv=INVOICES.map(([no,pid,amt,st,dt])=>{const p=PROJECTS.find(x=>x.id===pid);
    return `<tr onclick="drill('revenue')"><td><b>${no}</b></td><td>${p.name}</td><td>${p.customer}</td><td class="num">${cr(amt)}</td>
    <td><span class="badge b-${st==="Paid"?"good":st==="Sent"?"info":st==="Overdue"?"risk":"mut"}">${st}</span></td><td>${dt}</td></tr>`;}).join("");
  return `
  <div class="page-hd"><div><h1>Financial Control Tower</h1><p>${state.date.label} · revenue recognized on POC method · multi-currency (INR base, USD/EUR/SGD)</p></div>
  <div class="hd-actions"><button class="ghostbtn" onclick="drill('revenue')"><i class="fas fa-level-down-alt"></i> Revenue → GL drill</button><button class="ghostbtn" onclick="toast('Cash-flow forecast (13-week) exported for CFO review')">Cash-flow 13-wk</button><button class="ghostbtn" type="button" onclick="shareMenu(event)" title="Export / share / schedule"><i class="fas fa-share-alt"></i> Export / Share</button><button class="ghostbtn" type="button" onclick="openCopilot()">${copilotBtnIcon()} Copilot</button></div></div>
  <div class="grid kpi-grid">
    ${kpiCard({label:"Recognized revenue",value:cr(a.rev),delta:0,drill:"revenue"})}
    ${kpiCard({label:"Billed",value:"—",delta:0,drill:"revenue"})}
    ${kpiCard({label:"Collections",value:"—",delta:0,drill:"revenue"})}
    ${kpiCard({label:"WIP / unbilled",value:"—",delta:0,goodUp:false,drill:"revenue"})}
    ${kpiCard({label:"DSO",value:"—",delta:0,goodUp:false})}
    ${kpiCard({label:"Overdue AR",value:"—",delta:0,goodUp:false,drill:"revenue"})}
    ${kpiCard({label:"Burn rate",value:"—",delta:0,goodUp:false})}
    ${kpiCard({label:"Forecast Q2 (AI, P50)",value:"—",delta:0})}
  </div>
  <div class="grid g2 mt">
    ${widget("Billing vs collections","Monthly · overdue AR overlaid",`<div class="chartbox"><canvas id="chBill"></canvas></div>`,{drill:"revenue"})}
    ${widget("Profitability by portfolio","Gross margin % by project · colour = portfolio · sorted best → worst",`<div class="chartbox"><canvas id="chProf"></canvas></div>`,{drill:"revenue"})}
  </div>
  <div class="mt">${widget("Invoice register","Live status · click a row to drill to invoice lines → timesheets → GL · scroll for more rows","<div class='scroll-x grid-scroll'><table class='tbl'><thead><tr><th>Invoice</th><th>Project</th><th>Customer</th><th>Amount</th><th>Status</th><th>Date</th></tr></thead><tbody>"+inv+"</tbody></table></div>",{drill:"revenue"})}</div>`;
},

timesheets(){
  return `
  <div class="cxo-toolbar">
    <div class="exec-greet">
      <h1 id="greet">Resource Timesheets</h1>
      <p id="tsPageRange">${timesheetComplianceNoteHtml()}</p>
    </div>
    <div class="hd-actions">
      <button class="ghostbtn" type="button" onclick="drill('ts_billable')"><i class="fas fa-level-down-alt"></i> Effort Drill</button>
      <button class="ghostbtn" type="button" onclick="shareMenu(event)" title="Export / share / schedule"><i class="fas fa-share-alt"></i> Export / Share</button>
      <button class="ghostbtn" type="button" onclick="openCopilot()">${copilotBtnIcon()} Copilot</button>
    </div>
  </div>
  <div class="grid kpi-grid">
    ${kpiCard({label:"Submitted",value:"—",delta:0,drill:"ts_submitted",valId:"kpi-submitted-val",trendId:"kpi-submitted-trend"})}
    ${kpiCard({label:"Pending Approval",value:"—",delta:0,goodUp:false,drill:"ts_pending",valId:"kpi-pending-val",trendId:"kpi-pending-trend"})}
    ${kpiCard({label:"Rejected",value:"—",delta:0,goodUp:false,drill:"ts_rejected",valId:"kpi-rejected-val",trendId:"kpi-rejected-trend"})}
    ${kpiCard({label:"Approval SLA Met",value:"—",delta:0,drill:"ts_sla",valId:"kpi-sla-val",trendId:"kpi-sla-trend"})}
    ${kpiCard({label:"Billable Hours",value:"—",delta:0,drill:"ts_billable",valId:"kpi-billable-val",trendId:"kpi-billable-trend"})}
    ${kpiCard({label:"Non-Billable",value:"—",delta:0,goodUp:false,drill:"ts_nonbillable",valId:"kpi-nonbillable-val",trendId:"kpi-nonbillable-trend"})}
    ${kpiCard({label:"Overtime",value:"—",delta:0,goodUp:false,drill:"ts_overtime",valId:"kpi-overtime-val",trendId:"kpi-overtime-trend"})}
    ${kpiCard({label:"Productivity Index",value:"—",delta:0,drill:"ts_productivity",valId:"kpi-productivity-val",trendId:"kpi-productivity-trend"})}
  </div>
  <div class="grid g22 mt">
    ${widget("Billable Vs Non-Billable Mix","Hours By Portfolio · Click A Bar To Drill Into That Portfolio's Effort",`<div class="chartbox sm"><canvas id="chTS"></canvas></div>`,{drill:"ts_mix",tsGraph:"mix"})}
    ${widget("Approval Aging","Pending (Submitted + Resubmitted) By Hours Since Submit · Click A Bar",`<div class="chartbox sm"><canvas id="chTSAge"></canvas></div>`,{drill:"ts_aging",tsGraph:"aging"})}
  </div>`;
},

helpdesk(){
  return `
  <div class="page-hd"><div><h1>Help Desk & Support</h1><p>6 customer support lines · L1–L3 · follow-the-sun</p></div>
  <div class="hd-actions"><button class="ghostbtn" type="button" onclick="shareMenu(event)" title="Export / share / schedule"><i class="fas fa-share-alt"></i> Export / Share</button><button class="ghostbtn" type="button" onclick="openCopilot()">${copilotBtnIcon()} Copilot</button></div></div>
  <div class="grid kpi-grid">
    ${kpiCard({label:"Open tickets",value:"—",delta:0,goodUp:false})}
    ${kpiCard({label:"SLA compliance",value:"—",delta:0})}
    ${kpiCard({label:"Escalations",value:"—",delta:0,goodUp:false})}
    ${kpiCard({label:"Avg resolution",value:"—",delta:0,goodUp:false})}
    ${kpiCard({label:"Aging > 7 days",value:"—",delta:0,goodUp:false})}
    ${kpiCard({label:"CSAT (support)",value:"—",delta:0})}
  </div>
  <div class="grid g22 mt">
    ${widget("Ticket inflow vs resolution","Daily, last 14 days",`<div class="chartbox sm"><canvas id="chHD"></canvas></div>`)}
    ${widget("Root-cause Pareto","Top drivers of ticket volume",`<div class="chartbox sm"><canvas id="chRC"></canvas></div>`)}
  </div>`;
},

defects(){
  return `
  <div class="page-hd"><div><h1>Defects & Quality Engineering</h1><p>Portfolio quality gate · leakage target &lt; 4%</p></div>
  <div class="hd-actions"><button class="ghostbtn" type="button" onclick="shareMenu(event)" title="Export / share / schedule"><i class="fas fa-share-alt"></i> Export / Share</button><button class="ghostbtn" type="button" onclick="openCopilot()">${copilotBtnIcon()} Copilot</button></div></div>
  <div class="grid kpi-grid">
    ${kpiCard({label:"Open defects",value:"—",delta:0,goodUp:false,color:"var(--risk)"})}
    ${kpiCard({label:"Critical / Sev-1",value:"—",delta:0,goodUp:false})}
    ${kpiCard({label:"Defect leakage",value:"—",delta:0,goodUp:false})}
    ${kpiCard({label:"Reopened rate",value:"—",delta:0,goodUp:false})}
    ${kpiCard({label:"Avg resolution",value:"—",delta:0,goodUp:false})}
    ${kpiCard({label:"Automation coverage",value:"—",delta:0})}
  </div>
  <div class="grid g22 mt">
    ${widget("Defects by severity & project","Stacked · click to drill",`<div class="chartbox sm"><canvas id="chDef"></canvas></div>`,{drill:"projects"})}
    ${widget("Root cause distribution","Last 90 days",`<div class="chartbox sm"><canvas id="chDefRC"></canvas></div>`)}
  </div>`;
},

preview(){
  if(hoursState.from>hoursState.to) hoursState.to=hoursState.from;
  const ps=hoursVisible(),agg=hoursAggregate(),target=hoursSum(agg.target),actual=hoursSum(agg.actual);
  const variance=actual-target,performance=target?actual/target*100:null;
  const all=HOUR_PROJECTS.map((p,i)=>({i,...hoursTotals(p)}));
  const above=all.filter(x=>x.performance>110).length;
  const below=all.filter(x=>x.target&&x.performance<80).length;
  const noActual=all.filter(x=>x.target&&!x.actual).length;
  const inactive=all.filter(x=>!x.target&&!x.actual).length;
  const chartTitle=hoursState.project==="all"?"Portfolio performance":HOUR_PROJECTS[hoursState.project].name;
  const chartSub=`${HR_MONTHS[hoursState.from]}–${HR_MONTHS[hoursState.to]} 2026 · ${ps.length} project${ps.length===1?"":"s"}`;
  const monthOpts=(sel)=>HR_MONTHS.map((m,i)=>`<option value="${i}" ${i===sel?"selected":""}>${m} 2026</option>`).join("");
  const projOpts=`<option value="all" ${hoursState.project==="all"?"selected":""}>All projects</option>`+
    HOUR_PROJECTS.map((p,i)=>`<option value="${i}" ${String(hoursState.project)===String(i)?"selected":""}>${esc(p.name)}</option>`).join("");
  const chip=(id,label)=>`<button type="button" class="chipbtn ${hoursState.rangeChip===id?"on":""}" data-hr-range="${id}">${label}</button>`;
  const seg=(id,label)=>`<button type="button" class="seg-btn ${hoursState.view===id?"active":""}" data-hr-view="${id}">${label}</button>`;
  const rows=hoursTableData().map(r=>{
    const [s,c]=hoursStatus(r);
    return `<tr data-hr-i="${r.i}" class="${String(hoursState.project)===String(r.i)?"selected":""}">
      <td><b>${esc(r.name)}</b></td>
      <td class="num">${hoursFmt(r.target)}</td>
      <td class="num">${hoursFmt(r.actual)}</td>
      <td class="num">${r.variance>0?"+":""}${hoursFmt(r.variance)}</td>
      <td class="num">${r.performance===null?"—":hoursFmt(r.performance)+"%"}</td>
      <td><span class="badge b-${c}">${s}</span></td></tr>`;
  }).join("");
  return `
  <div class="page-hd"><div><h1>Project Hours Report</h1><p id="reportContext">Reporting period ${HR_MONTHS[hoursState.from]}–${HR_MONTHS[hoursState.to]} 2026 · ${ps.length} visible projects · target, actual &amp; variance</p></div>
    <div class="hd-actions"><button class="ghostbtn" onclick="drill('hours')"><i class="fas fa-level-down-alt"></i> Drill hours</button><button class="ghostbtn" id="hrCsvBtn">⬇ Download CSV</button><button class="ghostbtn" onclick="window.print()">🖨 Print report</button><button class="ghostbtn" type="button" onclick="shareMenu(event)" title="Export / share / schedule"><i class="fas fa-share-alt"></i> Export / Share</button><button class="ghostbtn" type="button" onclick="openCopilot()">${copilotBtnIcon()} Copilot</button></div></div>

  <div class="widget hours-filters">
    <div class="w-body">
      <div class="hours-filter-grid">
        <div class="hours-field"><label>From month</label><select id="hrFrom">${monthOpts(hoursState.from)}</select></div>
        <div class="hours-field"><label>To month</label><select id="hrTo">${monthOpts(hoursState.to)}</select></div>
        <div class="hours-field"><label>Project</label><select id="hrProject">${projOpts}</select></div>
        <div class="hours-field"><label>Metric</label><select id="hrMetric">
          <option value="hours" ${hoursState.metric==="hours"?"selected":""}>Hours</option>
          <option value="variance" ${hoursState.metric==="variance"?"selected":""}>Variance hours</option>
          <option value="variancePct" ${hoursState.metric==="variancePct"?"selected":""}>Variance %</option>
          <option value="performance" ${hoursState.metric==="performance"?"selected":""}>Actual / Target %</option>
        </select></div>
        <div class="hours-field"><label>Y axis</label><select id="hrAxis">
          <option value="auto" ${hoursState.axisMode==="auto"?"selected":""}>Auto scale</option>
          <option value="fixed" ${hoursState.axisMode==="fixed"?"selected":""}>Fixed 0–1000</option>
        </select></div>
        <div class="hours-field"><label>Project search</label><input id="hrFilterSearch" value="${esc(hoursState.filterSearch)}" placeholder="Filter project names…"></div>
      </div>
      <div class="hours-quick">
        <span class="hours-quick-label">Quick period</span>
        ${chip("ytd","YTD")}${chip("q1","Q1")}${chip("q2","Q2")}${chip("q3","Q3")}${chip("q4","Q4")}${chip("year","Full Year")}
        <label class="hours-check"><input type="checkbox" id="hrHideZero" ${hoursState.hideZero?"checked":""}> Hide zero projects</label>
        <button type="button" class="ghostbtn" id="hrReset" style="margin-left:auto">Reset filters</button>
      </div>
    </div>
  </div>

  <div class="grid kpi-grid mt">
    <div class="kpi" role="button" tabindex="0" data-drill="hours" title="Click to drill down"><div class="kpi-top"><span class="kpi-label">Target Hours</span></div><div class="kpi-val">${hoursFmt(target)} <small>hrs</small></div><div class="kpi-ai"><span class="sp">·</span><span>Selected reporting period</span></div></div>
    <div class="kpi" role="button" tabindex="0" data-drill="hours" title="Click to drill down"><div class="kpi-top"><span class="kpi-label">Actual Hours</span></div><div class="kpi-val">${hoursFmt(actual)} <small>hrs</small></div><div class="kpi-ai"><span class="sp">·</span><span>Selected reporting period</span></div></div>
    <div class="kpi" role="button" tabindex="0" data-drill="hours" title="Click to drill down"><div class="kpi-top"><span class="kpi-label">Variance</span></div><div class="kpi-val">${variance>0?"+":""}${hoursFmt(variance)} <small>hrs</small></div><div class="kpi-ai"><span class="sp">·</span><span>${variance>0?"Above target":"Below target / actual minus target"}</span></div></div>
    <div class="kpi" role="button" tabindex="0" data-drill="hours" title="Click to drill down"><div class="kpi-top"><span class="kpi-label">Actual / Target</span></div><div class="kpi-val">${performance===null?"—":hoursFmt(performance)+"%"}</div><div class="kpi-ai"><span class="sp">·</span><span>Consumption against target</span></div></div>
  </div>

  <div class="grid g2 mt">
    ${widget(chartTitle,chartSub,`
      <div class="seg" id="hrViewButtons">${seg("line","Line")}${seg("bar","Bar")}${seg("cumulative","Cumulative")}</div>
      <div class="chartbox" style="height:320px"><canvas id="chHours"></canvas></div>
      <div class="legend" id="hrLegend"></div>
      <div style="font-size:11px;color:var(--faint);margin-top:8px" id="hrAxisNote"></div>`,{drill:"hours"})}
    ${widget("Project exceptions","Click a category to filter & open drill-down",`
      <div class="hours-exceptions">
        <button type="button" class="hours-ex ${hoursState.exception==="above"?"on":""}" data-hr-ex="above"><div class="n">${above}</div><div class="t">Above target &gt; 10%</div><div class="d">Actual / Target above 110%</div></button>
        <button type="button" class="hours-ex ${hoursState.exception==="below"?"on":""}" data-hr-ex="below"><div class="n">${below}</div><div class="t">Below target &gt; 20%</div><div class="d">Actual / Target below 80%</div></button>
        <button type="button" class="hours-ex ${hoursState.exception==="noActual"?"on":""}" data-hr-ex="noActual"><div class="n">${noActual}</div><div class="t">Target but no actual</div><div class="d">No hours recorded in period</div></button>
        <button type="button" class="hours-ex ${hoursState.exception==="inactive"?"on":""}" data-hr-ex="inactive"><div class="n">${inactive}</div><div class="t">No activity</div><div class="d">Zero target and actual</div></button>
      </div>`)}
  </div>

  <div class="mt">${widget("Performance by project","Click a row to drill into monthly hours · click column headings to sort",`
    <div class="hours-table-tools"><input id="hrTableSearch" value="${esc(hoursState.tableSearch)}" placeholder="Search table…"></div>
    <div class="scroll-x grid-scroll"><table class="tbl" id="hrTable"><thead><tr>
      <th data-hr-sort="name">Project</th><th class="num" data-hr-sort="target">Target</th><th class="num" data-hr-sort="actual">Actual</th>
      <th class="num" data-hr-sort="variance">Variance</th><th class="num" data-hr-sort="performance">Actual / Target</th><th data-hr-sort="status">Status</th>
    </tr></thead><tbody>${rows}</tbody></table></div>`,{drill:"hours"})}</div>`;
}
};

function drawCharts(){
  const acc=css("--accent"),good=css("--good"),warn=css("--warn"),risk=css("--risk"),mut=css("--chart-tick");
  const m=months(),rev=trendSlice(REV_TREND),cost=trendSlice(COST_TREND);
  if($("#chRev")){
    const prev=rev.map(v=>Math.round(v*0.9));
    const fc=[...rev.map(()=>null).slice(0,-1),rev.at(-1),Math.round(rev.at(-1)*1.03),Math.round(rev.at(-1)*1.07)];
    mkChart("chRev",{type:"line",data:{labels:[...m,"Jul-26","Aug-26"],datasets:[
      {label:"Revenue",data:rev,borderColor:acc,backgroundColor:"rgba(71,158,245,.14)",fill:true,tension:.4,pointRadius:2},
      {label:"Cost",data:cost,borderColor:risk,tension:.4,pointRadius:0,borderWidth:1.6},
      ...(state.date.compare?[{label:compareModeMeta(state.date.compareMode).label,data:prev,borderColor:mut,borderDash:[3,4],pointRadius:0,tension:.4,borderWidth:1.2}]:[]),
      {label:"AI forecast",data:fc,borderColor:good,borderDash:[6,5],pointRadius:0,tension:.4}
    ]},options:baseOpts()},"revenue");
    const P=fp(),byPf=PORTFOLIOS.map(pf=>P.filter(p=>p.portfolio===pf).reduce((a,p)=>a+p.revenue,0)*scaleF());
    const mixTotal=byPf.reduce((a,b)=>a+b,0);
    const mixCenter=$("#chMixCenter");
    if(mixCenter){
      const mixVal=mixCenter.querySelector(".doughnut-center-value");
      if(mixVal) mixVal.textContent=cr(mixTotal);
    }
    mkChart("chMix",{type:"doughnut",data:{labels:PORTFOLIOS,datasets:[{data:byPf,backgroundColor:PORTFOLIOS.map(p=>PF_COLOR[p]),borderWidth:0,hoverOffset:8}]},
      options:baseOpts({cutout:"68%",scales:{},plugins:{legend:{display:false},
        tooltip:{backgroundColor:css("--surface-solid"),borderColor:css("--border-strong"),borderWidth:1,titleColor:css("--text"),bodyColor:css("--muted"),padding:10,cornerRadius:10,displayColors:false,
          callbacks:{
            title:items=>items && items[0] ? items[0].label : "",
            label:c=>{
              const val=Number(c.raw)||0;
              const share=mixTotal?(val/mixTotal*100):0;
              const n=P.filter(p=>p.portfolio===c.label).length;
              return `${cr(val)} · ${share.toFixed(1)}% · ${n} project(s)`;
            }
          }}}})},"revenue");
    mkChart("chVar",{type:"bar",data:{labels:fp().map(p=>p.id),datasets:[{label:"Budget burn %",data:fp().map(p=>Math.round(p.spent/p.budget*100)),
      backgroundColor:fp().map(p=>p.spent>p.budget?risk:p.spent/p.budget>.85?warn:good),borderRadius:6}]},options:baseOpts()},"projects");
  }
  if($("#chEVM")){
    const P=[...fp()].sort((x,y)=>x.spi-y.spi);
    mkChart("chEVM",{type:"bar",data:{labels:P.map(p=>p.name.length>26?p.name.slice(0,25)+"…":p.name),datasets:[
      {label:"Schedule vs plan",data:P.map(p=>+((p.spi-1)*100).toFixed(1)),backgroundColor:"#479EF5",borderRadius:4,barPercentage:.75},
      {label:"Cost vs plan",data:P.map(p=>+((p.cpi-1)*100).toFixed(1)),backgroundColor:"#9373C0",borderRadius:4,barPercentage:.75}]},
      options:baseOpts({indexAxis:"y",plugins:{legend:{display:false},tooltip:{backgroundColor:css("--surface-solid"),borderColor:css("--border-strong"),borderWidth:1,titleColor:css("--text"),bodyColor:css("--muted"),padding:10,cornerRadius:10,
        callbacks:{label:c=>{const p=P[c.dataIndex];return c.datasetIndex===0?`SPI ${p.spi.toFixed(2)} → ${c.raw>0?"+":""}${c.raw}% vs schedule`:`CPI ${p.cpi.toFixed(2)} → ${c.raw>0?"+":""}${c.raw}% vs cost plan`;}}}},
        scales:{x:{min:-30,max:15,ticks:{color:css("--chart-tick"),font:{size:10.5},callback:v=>v+"%"},grid:{color:css("--grid-line")},title:{display:true,text:"% deviation from plan (0 = on target)",color:css("--chart-tick"),font:{size:10.5}}},
                y:{ticks:{color:css("--chart-tick"),font:{size:10.5}},grid:{color:"transparent"}}}})},"projects");
  }
  if($("#chEV"))mkChart("chEV",{type:"line",data:{labels:m,datasets:[
    {label:"Planned value",data:cost.map(v=>v*1.05),borderColor:mut,borderDash:[4,4],pointRadius:0,tension:.35},
    {label:"Earned value",data:cost.map(v=>v*0.97),borderColor:acc,tension:.35,pointRadius:2},
    {label:"Actual cost",data:cost,borderColor:risk,tension:.35,pointRadius:0}]},options:baseOpts()});
  if($("#chCR"))mkChart("chCR",{type:"bar",data:{labels:["Draft","Submitted","In review","Approved","Rejected"],datasets:[{label:"Change requests",data:[],backgroundColor:[mut,warn,acc,good,risk],borderRadius:6}]},options:baseOpts()});
  if($("#chCap"))mkChart("chCap",{type:"bar",data:{labels:SKILLS.map(s=>s[0]),datasets:[
    {label:"Capacity",data:SKILLS.map(s=>s[1]),backgroundColor:acc,borderRadius:5},
    {label:"Demand",data:SKILLS.map(()=>0),backgroundColor:warn,borderRadius:5}]},options:baseOpts({indexAxis:"y"})});
  if($("#chSkill"))mkChart("chSkill",{type:"doughnut",data:{labels:SKILLS.map(s=>s[0]),datasets:[{data:SKILLS.map(s=>s[1]),backgroundColor:["#479EF5","#54B054","#9373C0","#EAA300","#4DB1D3","#DC626D","#77B7B2"],borderWidth:0}]},options:{...baseOpts(),cutout:"66%",scales:{}}});
  if($("#chBill"))mkChart("chBill",{type:"bar",data:{labels:m,datasets:[
    {label:"Billed",data:rev.map(v=>Math.round(v*0.91)),backgroundColor:acc,borderRadius:5},
    {label:"Collected",data:rev.map(v=>Math.round(v*0.83)),backgroundColor:good,borderRadius:5},
    {type:"line",label:"Overdue AR",data:rev.map(()=>null),borderColor:risk,tension:.4,pointRadius:2}]},options:baseOpts()},"revenue");
  if($("#chProf")){
    const P=[...fp()].sort((x,y)=>((y.revenue-y.cost)/y.revenue)-((x.revenue-x.cost)/x.revenue));
    mkChart("chProf",{type:"bar",data:{labels:P.map(p=>p.name.length>24?p.name.slice(0,23)+"…":p.name),datasets:[
      {label:"Gross margin %",data:P.map(p=>+((p.revenue-p.cost)/p.revenue*100).toFixed(1)),backgroundColor:P.map(p=>PF_COLOR[p.portfolio]),borderRadius:4}]},
      options:baseOpts({indexAxis:"y",plugins:{legend:{display:false},tooltip:{backgroundColor:css("--surface-solid"),borderColor:css("--border-strong"),borderWidth:1,titleColor:css("--text"),bodyColor:css("--muted"),padding:10,cornerRadius:10,
        callbacks:{label:c=>{const p=P[c.dataIndex];return `Margin ${c.raw}% · Revenue ${cr(p.revenue*scaleF())} · ${p.portfolio}`;}}}},
        scales:{x:{ticks:{color:mut,callback:v=>v+"%"},grid:{color:css("--grid-line")},title:{display:true,text:"Gross margin % (colour = portfolio)",color:mut,font:{size:10.5}}},
                y:{ticks:{color:mut,font:{size:10.5}},grid:{color:"transparent"}}}})},"revenue");
  }
  if($("#chHD"))mkChart("chHD",{type:"line",data:{labels:[],datasets:[]},options:baseOpts()});
  if($("#chRC"))mkChart("chRC",{type:"bar",data:{labels:[],datasets:[]},options:baseOpts({indexAxis:"y"})});
  if($("#chDef"))mkChart("chDef",{type:"bar",data:{labels:[],datasets:[]},options:baseOpts()},"projects");
  if($("#chDefRC"))mkChart("chDefRC",{type:"doughnut",data:{labels:[],datasets:[{data:[],backgroundColor:[],borderWidth:0}]},options:{...baseOpts(),cutout:"66%",scales:{}}});
  drawHoursChart();
}

/* =====================================================================
   HIERARCHICAL DRILL-DOWN ENGINE  (KPI → transaction → audit trail)
===================================================================== */
function tbl(head,rows){
  state.lastDrillRows=[head,...(rows||[]).map(r=>(r.exportCells||r.cells||[]).map(c=>String(c).replace(/<[^>]*>/g,"").trim()))];
  if(!rows || !rows.length) return `<div class="m-note">No rows for this selection.</div>`;
  return `<div class="scroll-x grid-scroll"><table class="tbl"><thead><tr>${head.map(h=>`<th scope="col">${h}</th>`).join("")}</tr></thead><tbody>`+
    rows.map(r=>{
      const next=canDrillNext(r.next)?r.next:null;
      const linkOnly=!!(r.linkOnly && next);
      const cls=next?(linkOnly?"drill-row-linkonly":"drill-row"):"";
      const click=next&&!linkOnly?`onclick='drillNext(${JSON.stringify(next)})' style="cursor:pointer"`:"";
      return `<tr${cls?` class="${cls}"`:""} ${click}>${r.cells.map(c=>`<td>${c}</td>`).join("")}</tr>`;
    }).join("")+"</tbody></table></div>";
}
function exportDrill(){
  exportDrillAs("csv");
}
/* =====================================================================
   GANTT & CRITICAL PATH (Projects & Portfolio Governance)
===================================================================== */
function ganttHTML(){
  const P=fp();
  const monthsAll=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
  const rowData=P.map((p,i)=>{
    const start=i%8;
    const dur=Math.min(3+Math.round(p.budget/300),6);
    const isCrit=p.risk==="Critical"||p.risk==="High";
    return {p,start,dur,isCrit};
  });
  const criticalCount=rowData.filter(r=>r.isCrit).length;
  const depCount=P.length*2-criticalCount;
  const header=monthsAll.map(m=>`<div class="gantt-hcell">${m}</div>`).join("");
  const rows=rowData.map(({p,start,dur,isCrit})=>{
    const color=isCrit?"var(--risk)":p.health==="Amber"?"var(--warn)":"var(--good)";
    return `<div class="gantt-row">
      <div class="gantt-label">${isCrit?"⚡ ":""}<b>${p.name}</b><div style="font-size:10px;color:var(--faint)">${p.id} · ${p.pm}</div></div>
      <div class="gantt-track">
        <div class="gantt-bar" style="left:${(start/12*100).toFixed(1)}%;width:${(dur/12*100).toFixed(1)}%;background:${color};${isCrit?"outline:2px solid var(--risk);outline-offset:-2px;":""}" title="${esc(p.name)} · ${isCrit?"Critical path":"Non-critical"} · ${dur} mo"></div>
      </div>
    </div>`;
  }).join("");
  state.lastDrillRows=[["Project","PM","Relative start","Duration (mo)","Critical path","Risk"],
    ...rowData.map(({p,start,dur,isCrit})=>[p.name,p.pm,monthsAll[start],dur+" mo",isCrit?"Yes":"No",p.risk])];
  return `<div class="m-note">FY 2026-27 timeline (relative) · <b>${criticalCount} project(s) on the critical path</b> (bold outline, ⚡) · ${depCount} dependency links tracked across the in-scope portfolio.</div>
  <div class="gantt-wrap">
    <div class="gantt-row gantt-headrow"><div class="gantt-label"></div><div class="gantt-track gantt-headtrack">${header}</div></div>
    ${rows}
  </div>
  <div class="legend mt"><span><i style="background:var(--risk)"></i>Critical path</span><span><i style="background:var(--warn)"></i>At risk (non-critical)</span><span><i style="background:var(--good)"></i>On track</span></div>`;
}
function openGantt(){
  closeMenus();
  $("#overlay").classList.add("open");
  $("#mTitle").textContent="Gantt & Critical Path";
  $("#mCrumbs").innerHTML=`<span>${fp().length} projects in current filter scope</span>`;
  renderDrillFilterBar("revenue",[]);
  $("#mBody").innerHTML=ganttHTML();
  setTrail([]);
}

function cxoHealthBadge(h){
  const v=String(h||"").trim();
  let cls="info";
  if(/green/i.test(v)) cls="good";
  else if(/amber|yellow|orange/i.test(v)) cls="warn";
  else if(/red|critical/i.test(v)) cls="risk";
  if(!v||v==="—") return "—";
  return `<span class="badge b-${cls}">${esc(v)}</span>`;
}
function cxoStatusBadge(s){
  const v=String(s||"").trim();
  let cls="info";
  if(/paid|approved|done/i.test(v)) cls="good";
  else if(/overdue|reject/i.test(v)) cls="risk";
  else if(/sent|pending|review/i.test(v)) cls="warn";
  return `<span class="badge b-${cls}">${esc(v||"—")}</span>`;
}
function cxoDrillDescLink(text,next){
  if(!canDrillNext(next)) return esc(text);
  return `<a href="javascript:void(0)" class="drill-desc-link" onclick='event.preventDefault();event.stopPropagation();drillNext(${JSON.stringify(next)})'>${esc(text)}</a>`;
}

const DRILL={
revenue:{
  title:"Revenue drill-through · KPI → General Ledger",
  levels:[
    {label:"Portfolio",render:()=>{const P=fp(),s=scaleF();
      const rows=PORTFOLIOS.map(pf=>{
        const pp=P.filter(p=>p.portfolio===pf);
        const r=pp.reduce((a,p)=>a+p.revenue,0)*s,c=pp.reduce((a,p)=>a+p.cost,0)*s;
        const gp=r-c;
        return {pf,pp,r,c,gp};
      });
      const tot=rows.reduce((a,x)=>a+x.r,0)||1;
      return tbl(["Portfolio","Projects","Revenue","Cost","Gross profit","Gross margin","Share"],rows.map(x=>{
        const margin=x.r?(x.gp/x.r*100):0;
        const share=x.r/tot*100;
        return {cells:[
          `<b>${esc(x.pf)}</b>`,
          String(x.pp.length),
          `<span class="num">${cr(x.r)}</span>`,
          `<span class="num">${cr(x.c)}</span>`,
          `<span class="num">${cr(x.gp)}</span>`,
          x.r?pct(margin):"—",
          `<span class="num">${pct(share)}</span>`
        ], next:{level:1,key:x.pf,label:x.pf}};
      }))}},
    {label:"Projects",render:pf=>tbl(["Project","Customer","PM","Billing","Source currency","Revenue","Cost","Gross Margin (%)","Health"],
      fp().filter(p=>p.portfolio===pf).map(p=>{
        const rev=p.revenue*scaleF(), cost=p.cost*scaleF();
        const cur=REGION_CURRENCY[(p.region||"").split(" · ")[0]]||"INR";
        const fx=cur!=="INR"?` <span class="badge b-mut" title="Converted at the monthly-average Treasury rate">@ ₹${FX_RATES[cur]}</span>`:"";
        return {cells:[
          `<b>${esc(p.name)}</b><div style="font-size:10px;color:var(--faint)">${esc(p.id)}</div>`,
          esc(p.customer||"—"),
          esc(p.pm||"—"),
          esc(p.billing||"—"),
          esc(cur)+fx,
          `<span class="num">${cr(rev)}</span>`,
          `<span class="num">${cr(cost)}</span>`,
          rev?pct((rev-cost)/rev*100):"—",
          cxoHealthBadge(p.health)
        ], next:{level:2,key:p.id,label:p.name}};
      }))},
    {label:"Invoices",render:pid=>{const rows=INVOICES.filter(i=>i[1]===pid);
      return (rows.length?tbl(["IR","Amount","Status","Date","PO reference","Ageing"],rows.map(i=>{
        const age=i[3]==="Overdue"?"past due":i[3]==="Paid"?"settled":"within terms";
        return {cells:[
          `<b>${esc(i[0])}</b>`,
          `<span class="num">${cr(i[2])}</span>`,
          "NA",
          esc(i[4]||"—"),
          esc("PO-88"+String(i[0]).slice(-2)),
          esc(age)
        ], next:{level:3,key:i[0],label:i[0]}};
      })):"<div class='m-note'>No rows for this level in the selected period.</div>")}},
    {label:"Invoice lines",render:()=>tbl(["Line","Description","Quantity","Rate","Amount","Source"],[])},
    {label:"Timesheets",render:()=>tbl(["Timesheet date","Employee","Task","Duration","Billable"],[])},
    {label:"Audit trail",render:()=>tbl(["Timestamp (IST)","Actor","Event","Detail"],[])}
  ]},
util:{
  title:"Utilization drill-through · Resource → timesheet entry",
  levels:[
    {label:"Portfolios",render:()=>tbl(["Portfolio","Avg utilization","Billable h (wk)","Bench exposure"],PORTFOLIOS.map(pf=>{
      const pp=fp().filter(p=>p.portfolio===pf);const u=pp.length?pp.reduce((a,p)=>a+p.util,0)/pp.length:0;
      return {cells:[`<b style="color:${PF_COLOR[pf]}">● ${pf}</b>`,pct(u),Math.round(u*38),u<80?'<span class="badge b-warn">soft</span>':'<span class="badge b-good">healthy</span>'],next:{level:1,key:pf,label:pf}};}))},
    {label:"Projects",render:pf=>tbl(["Project","PM","Utilization","FTE","Status"],fp().filter(p=>p.portfolio===pf).map(p=>({cells:[`<b>${p.name}</b>`,p.pm,pct(p.util),Math.round(p.budget/45),p.status],next:{level:2,key:p.id,label:p.name}})))},
    {label:"Resources",render:pid=>tbl(["Resource","Role","6-wk avg","This week","Allocation"],RESOURCES.filter(r=>r[4]===pid||r[4]==="BENCH").slice(0,5).map(r=>({cells:[`<b>${r[0]}</b>`,r[1],pct(r[3].reduce((a,b)=>a+b)/6),pct(r[3][5]),r[4]==="BENCH"?'<span class="badge b-risk">Bench</span>':'<span class="badge b-good">100%</span>'],next:{level:3,key:r[0],label:r[0]}})))},
    {label:"Timesheet entries",render:()=>tbl(["Date","Task","Hours","Type","Status"],[])}
  ]},
projects:{
  title:"Project drill-through · Portfolio → work item",
  levels:[
    {label:"Projects",render:()=>tbl(["Project","Health","SPI","CPI","Delay","Milestones"],fp().map(p=>({cells:[`<b>${p.name}</b><div style="font-size:10px;color:var(--faint)">${p.customer}</div>`,healthBadge(p.health),p.spi.toFixed(2),p.cpi.toFixed(2),p.delayDays?p.delayDays+"d":"—",p.milestones.length],next:{level:1,key:p.id,label:p.name}})))},
    {label:"Milestones",render:pid=>{const p=PROJECTS.find(x=>x.id===pid);
      return tbl(["Milestone","Due","Status","Owner"],p.milestones.map(m=>({cells:[`<b>${m[0]}</b>`,m[1],`<span class="badge b-${m[2]==="On track"?"good":m[2]==="At risk"?"warn":"risk"}">${m[2]}</span>`,p.pm],next:{level:2,key:pid,label:m[0]}})))}},
    {label:"Tasks & work items",render:()=>tbl(["Work item","Assignee","Est / actual (h)","State"],[])},
    {label:"Timesheets & activity log",render:()=>tbl(["Timestamp","Actor","Activity"],[])}
  ]},
hours:{
  title:"Project hours drill-through · Portfolio → month → timesheets",
  levels:[
    {label:"Projects",render:()=>{
      const rows=hoursTableData();
      if(!rows.length) return "<div class='m-note'>No projects match the current hours filters / exception selection.</div>";
      return tbl(["Project","Target","Actual","Variance","Actual / Target","Status"],rows.map(r=>{
        const [s,c]=hoursStatus(r);
        return {cells:[`<b>${esc(r.name)}</b>`,`<span class="num">${hoursFmt(r.target)}</span>`,`<span class="num">${hoursFmt(r.actual)}</span>`,`<span class="num">${r.variance>0?"+":""}${hoursFmt(r.variance)}</span>`,`<span class="num">${r.performance===null?"—":hoursFmt(r.performance)+"%"}</span>`,`<span class="badge b-${c}">${s}</span>`],
          next:{level:1,key:String(r.i),label:r.name}};
      }));
    }},
    {label:"Monthly hours",render:idx=>{
      const p=HOUR_PROJECTS[+idx]; if(!p) return "<div class='m-note'>Project not found.</div>";
      return tbl(["Month","Target","Actual","Variance","Actual / Target"],hoursRange().map(i=>{
        const t=p.target[i]||0,a=p.actual[i]||0,v=a-t,perf=t?a/t*100:null;
        return {cells:[`<b>${HR_MONTHS[i]} 2026</b>`,`<span class="num">${hoursFmt(t)}</span>`,`<span class="num">${hoursFmt(a)}</span>`,`<span class="num">${v>0?"+":""}${hoursFmt(v)}</span>`,`<span class="num">${perf===null?"—":hoursFmt(perf)+"%"}</span>`],
          next:{level:2,key:idx+"|"+i,label:HR_MONTHS[i]+" 2026"}};
      }));
    }},
    {label:"Timesheet entries",render:()=>tbl(["Date","Resource","Task","Hours","Type","Status"],[])},
    {label:"Audit trail",render:()=>tbl(["Timestamp (IST)","Actor","Event","Detail"],[])}
  ]}
};

/* Timesheet drill UI/content lives on Resource_Timesheet_Dash.aspx (TimesheetDrill). */
let drillStack=[];
function resolveTimesheetDrillType(type){
  if(window.TimesheetDrill && typeof TimesheetDrill.isType==="function" && TimesheetDrill.isType(type)) return type;
  if(typeof TS_DRILL_API!=="undefined" && TS_DRILL_API[type]) return type;
  if(isTimesheetPage()){
    if(type==="util"||type==="revenue") return "ts_billable";
  }
  return null;
}
function drill(type){
  if(isTimesheetPage() && window.TimesheetDrill && typeof TimesheetDrill.open==="function"){
    var pageType=resolveTimesheetDrillType(type)||type;
    if(TimesheetDrill.isType(pageType) || TimesheetDrill.isType(type)){
      TimesheetDrill.open(pageType, 1, {portfolioID:0,projectID:0,employeeID:0});
      return;
    }
    toast("Only Timesheet drills are available on this page");
    return;
  }
  var sharedType=resolveTimesheetDrillType(type);
  if(sharedType && typeof openTimesheetDrill==="function"){
    TimesheetDrillState={apiName:null,level:1,portfolioID:0,projectID:0,employeeID:0,stack:[]};
    openTimesheetDrill(sharedType, 1, {portfolioID:0,projectID:0,employeeID:0}, [{type:sharedType,level:1,label:(typeof TS_DRILL_LEVEL_LABELS!=="undefined"&&TS_DRILL_LEVEL_LABELS[1])||"Portfolio"}]);
    return;
  }
  if(DRILL[type] && DRILL[type].levels && DRILL[type].levels.length){
    drillTo(type,[{type:type,level:0,key:null,label:DRILL[type].levels[0].label}]);
    return;
  }
  if(isTimesheetPage()){
    toast("Only Timesheet drills are available on this page");
    return;
  }
  toast("Drill-down API is not bound for this item yet");
}
function drillChipKind(levelLabel){
  const map={
    Portfolios:"Portfolio", Groups:"Portfolio", Portfolio:"Portfolio", Projects:"Project", Invoices:"Invoice",
    "Invoice lines":"Line", Timesheets:"Timesheet", "Timesheet entries":"Timesheet", Resources:"Resource",
    Milestones:"Milestone", "Monthly hours":"Month", Entries:"Entry"
  };
  if(map[levelLabel]) return map[levelLabel];
  return String(levelLabel||"Filter").replace(/s$/i,"");
}
function drillFilterChips(type,stack){
  const chips=[];
  const seen={};
  function addChip(kind,value){
    const k=String(kind||"").trim(), v=String(value||"").trim();
    if(!k||!v) return;
    const id=k.toLowerCase()+"|"+v.toLowerCase();
    if(seen[id]) return;
    seen[id]=true;
    chips.push({kind:k,value:v});
  }
  Object.entries(state.filters||{}).forEach(([kind,vals])=>{
    (vals||[]).forEach(v=>addChip(kind,v));
  });
  const def=DRILL[type];
  const levels=def && def.levels ? def.levels : [];
  for(let i=1;i<stack.length;i++){
    const prev=stack[i-1];
    const prevLevel=levels[prev && prev.level!=null?prev.level:i-1];
    addChip(drillChipKind((prevLevel && prevLevel.label) || prev.label), stack[i].label);
  }
  return chips;
}
function ensureDrillFilterBar(){
  let el=$("#mFilters");
  if(el) return el;
  const hd=document.querySelector("#overlay .m-hd");
  if(!hd || !hd.parentNode) return null;
  el=document.createElement("div");
  el.id="mFilters";
  el.className="m-filtered-by";
  el.hidden=true;
  hd.after(el);
  return el;
}
function renderDrillFilterBar(type,stack){
  const bar=ensureDrillFilterBar();
  if(!bar) return;
  const chips=drillFilterChips(type,stack||[]);
  if(!chips.length){
    bar.hidden=true;
    bar.innerHTML="";
    return;
  }
  bar.hidden=false;
  bar.innerHTML=`<span class="m-filtered-label">Filtered by:</span>`+
    chips.map(c=>`<span class="m-filter-chip"><span class="m-filter-kind">${esc(c.kind)}</span> <span class="m-filter-val">${esc(c.value)}</span></span>`).join("");
}
function drillTo(type,stack){
  if(!DRILL[type]){ toast("No drill path for this item"); return; }
  drillStack=stack; const def=DRILL[type]; const levels=getDrillLevels(def); const top=stack[stack.length-1];
  if(!levels.length || top.level>=levels.length){
    toast("No further drill-down for this selection");
    return;
  }
  $("#overlay").classList.add("open");
  $("#mTitle").textContent=def.title;
  $("#mCrumbs").innerHTML=stack.map((s,i)=>`${i?"<span>›</span>":""}<button type="button" onclick="drillTo('${type}',drillStack.slice(0,${i+1}))">${esc(s.label)}</button>`).join("");
  renderDrillFilterBar(type,stack);
  $("#mBody").innerHTML=`<div class="m-note">Level ${top.level+1} of ${levels.length}</div>`+levels[top.level].render(top.key);
  setTrail(stack.map(s=>({...s,type})));
}
function drillNext(next){
  if(!canDrillNext(next)) return;
  const type=drillStack[0].type;
  drillTo(type,[...drillStack,{type,...next}]);
}
function drillProject(pid){ const p=PROJECTS.find(x=>x.id===pid);
  drillTo("projects",[{type:"projects",level:0,key:null,label:"Projects"},{type:"projects",level:1,key:pid,label:p.name}]); }
function drillHoursProject(i){
  const p=HOUR_PROJECTS[+i]; if(!p) return;
  hoursState.project=String(i); hoursState.exception=null;
  drillTo("hours",[
    {type:"hours",level:0,key:null,label:"Projects"},
    {type:"hours",level:1,key:String(i),label:p.name}
  ]);
}
function closeModal(){
  if(window.TimesheetDrill && typeof TimesheetDrill.close==="function") TimesheetDrill.close();
  const ov=$("#overlay");
  if(ov) ov.classList.remove("open");
  const bar=$("#mFilters");
  if(bar){ bar.hidden=true; bar.innerHTML=""; }
}
if(!window.SKIP_APP_JS_BOOT){
const _overlayEl=$("#overlay");
if(_overlayEl) _overlayEl.addEventListener("click",e=>{if(e.target.id==="overlay")closeModal();});
document.addEventListener("keydown",e=>{
  if(e.key==="Escape"){closeModal();const cp=$("#copilot"); if(cp)cp.classList.remove("open");}
  if((e.metaKey||e.ctrlKey)&&e.key.toLowerCase()==="k"){const nlq=$("#nlq"); if(nlq){e.preventDefault();nlq.focus();}}
});
}

/* =====================================================================
   AI COPILOT — grounded canned intelligence + what-if planner
===================================================================== */
function cpMsg(txt,who){
  const log=$("#cpLog");
  if(!log) return;
  const d=document.createElement("div");
  d.className="msg "+who;
  d.innerHTML=txt;
  log.appendChild(d);
  log.scrollTop=1e9;
}
if(!window.SKIP_APP_JS_BOOT){
const copilotBtn=$("#copilotBtn"); if(copilotBtn)copilotBtn.onclick=()=>openCopilot();
$$("[data-open-copilot]").forEach(b=>b.onclick=()=>openCopilot());
}
function sendCopilot(){ openCopilot(); }
function askCopilot(q){ openCopilot(); }
function copilotAnswer(q){
  const a=agg();
  const period=state.date.label||"current period";
  const snapshot=`revenue <b>${cr(a.rev)}</b>, gross margin <b>${pct(a.margin)}</b>, utilization <b>${pct(a.util)}</b>, delayed projects <b>${a.delayed}</b>, bench <b>${a.bench}</b>`;
  if(q.includes("timesheet")||q.includes("pending")||q.includes("billable")||q.includes("sla")||q.includes("approv"))
    return `<b>Timesheet (current filters)</b>\nPeriod <b>${period}</b>.\n\nNo canned timesheet narrative is loaded. Use the live KPI cards and drills on this page.`;
  if(q.includes("profit")||q.includes("margin")||q.includes("drop"))
    return `<b>Profitability (current filters)</b>\nPeriod <b>${period}</b>.\n\n${snapshot}.\n\nNo additional root-cause narrative is available beyond the values on screen.`;
  if(q.includes("risk")||q.includes("delay")||q.includes("banking"))
    return `<b>Delivery risk (current filters)</b>\nPeriod <b>${period}</b>.\n\nDelayed projects: <b>${a.delayed}</b>. Open the Delayed Projects card to drill into live rows.`;
  if(q.includes("bench")||q.includes("util"))
    return `<b>Utilization &amp; bench (current filters)</b>\nUtilization <b>${pct(a.util)}</b> · Bench <b>${a.bench}</b>.\n\nOpen the Utilization or Bench card to drill into live rows.`;
  if(q.includes("forecast")||q.includes("revenue"))
    return `<b>Revenue (current filters)</b>\nPeriod <b>${period}</b>.\n\nRevenue on screen: <b>${cr(a.rev)}</b>. Use Drill revenue for live rows.`;
  if(q.includes("simulate")||q.includes("moving")||q.includes("what-if")||q.includes("what if"))
    return `<b>Scenario</b>\nLive baseline: ${snapshot}.\n\nNo simulated staffing or named-project scenario is applied.`;
  return `Here's what I can see in the <b>${period}</b> scope: ${snapshot}.\n\nTry: <i>"Why did profitability drop?"</i>, <i>"Show delayed projects"</i>, or <i>"Forecast revenue for next quarter"</i>.`;
}
function whatIf(){
  const hiresEl=$("#wiHires"), rateEl=$("#wiRate");
  if(!hiresEl||!rateEl) return;
  const h=+hiresEl.value, r=+rateEl.value, a=agg();
  const hiresV=$("#wiHiresV"), rateV=$("#wiRateV");
  if(hiresV) hiresV.textContent=h;
  if(rateV) rateV.textContent=(r>0?"+":"")+r+"%";
  const util=Math.max(60,Math.min(96,a.util - h*0.55 + 1.2));
  const rev=a.rev*(1+r/100)+h*4.6;
  const margin=a.margin + r*0.62 - h*0.12;
  const wiUtil=$("#wiUtil"), wiRev=$("#wiRev"), wiMargin=$("#wiMargin");
  if(wiUtil){ wiUtil.textContent=pct(util); wiUtil.style.color=util<75?"var(--warn)":"var(--good)"; }
  if(wiRev) wiRev.textContent=cr(rev);
  if(wiMargin) wiMargin.textContent=pct(margin);
}
if(!window.SKIP_APP_JS_BOOT){
const wiHires=$("#wiHires"), wiRate=$("#wiRate");
if(wiHires) wiHires.oninput=whatIf;
if(wiRate) wiRate.oninput=whatIf;

/* natural-language query box routes to copilot */
const nlq=$("#nlq");
if(nlq)nlq.addEventListener("keydown",e=>{
  if(e.key==="Enter"&&e.target.value.trim()){openCopilot(e.target.value.trim());e.target.value="";}
});
}

/* =====================================================================
   NAV, ROLES, THEME, INIT
===================================================================== */
const PAGE_NAMES={exec:"CXO Dashboard",projects:"Projects & Portfolio",resources:"Resources",finance:"Financials",timesheets:"Timesheets",helpdesk:"Help Desk",defects:"Defects & Quality",preview:"Project Hours Report"};
function setPage(p){
  state.page=p;
  $$(".nav-btn[data-page]").forEach(b=>b.classList.toggle("active",b.dataset.page===p));
  $$(".content").forEach(c=>c.classList.toggle("active",c.id==="page-"+p));
  const crumb=$("#crumbPage"); if(crumb)crumb.textContent=PAGE_NAMES[p];
  renderPage();
}
if(!window.SKIP_APP_JS_BOOT){
$$(".nav-btn[data-page]").forEach(b=>{
  if(b.tagName!=="A") b.onclick=()=>setPage(b.dataset.page); // real <a href="x.html"> nav items navigate natively
});
$$(".nav-group-btn").forEach(b=>b.onclick=()=>{
  b.classList.toggle("closed");
  document.getElementById(b.dataset.group).classList.toggle("closed");
});
}
function refreshDashboardData(ev){
  if(ev){ ev.preventDefault(); ev.stopPropagation(); }
  if(isTimesheetPage() && document.getElementById("kpi-submitted-val")){
    if(typeof syncDateUI==="function") syncDateUI();
    loadDashboardKPIs();
    if(typeof toast==="function") toast("Timesheet data refreshed");
    return;
  }
  if(typeof toast==="function") toast("Widget refreshed · data as of 2 min ago");
  renderPage();
}
window.refreshDashboardData=refreshDashboardData;
function hideBlackTooltips(){
  try{
    document.querySelectorAll("body > .tooltip").forEach(t=>{
      if(t.parentNode) t.parentNode.removeChild(t);
    });
  }catch(err){}
}
function initBlackTooltips(root){
  const scope=root||document;
  if(!window.bootstrap || !bootstrap.Tooltip) return;
  let nodes=[];
  try{
    if(scope.querySelectorAll) nodes=Array.prototype.slice.call(scope.querySelectorAll("[title], [data-bs-original-title], [data-cxo-tip]"));
    if(root && root.nodeType===1){
      if(root.getAttribute("title")||root.getAttribute("data-cxo-tip")||root.getAttribute("data-bs-original-title")) nodes.unshift(root);
    }
  }catch(err){ return; }
  nodes.forEach(el=>{
    let text=el.getAttribute("title")||el.getAttribute("data-cxo-tip")||el.getAttribute("data-bs-original-title")||"";
    text=String(text).trim();
    if(!text) return;
    if(el.tagName==="INPUT"||el.tagName==="TEXTAREA"||el.tagName==="SELECT") return;
    try{
      const existing=bootstrap.Tooltip.getInstance(el);
      if(existing) existing.dispose();
    }catch(err){}
    el.setAttribute("data-cxo-tip", text);
    el.setAttribute("data-bs-toggle", "tooltip");
    el.setAttribute("data-bs-title", text);
    el.removeAttribute("title");
    try{
      new bootstrap.Tooltip(el, {
        container: "body",
        customClass: "cxo-black-tooltip",
        trigger: "hover focus",
        placement: el.getAttribute("data-bs-placement") || "top",
        animation: true
      });
    }catch(err){}
  });
}
function bindBlackTooltipDismiss(){
  if(bindBlackTooltipDismiss._done) return;
  bindBlackTooltipDismiss._done=true;
  document.addEventListener("scroll", hideBlackTooltips, true);
  document.addEventListener("mousedown", hideBlackTooltips, true);
  document.addEventListener("touchstart", hideBlackTooltips, true);
}
window.initBlackTooltips=initBlackTooltips;
window.hideBlackTooltips=hideBlackTooltips;

function renderPage(){
  closeWidgetFS();
  if(typeof hideBlackTooltips==="function") hideBlackTooltips();
  { const npc=$("#navProjCount"); if(npc) npc.textContent=fp().length; }
  /* Timesheet: keep the existing cards/charts; only reload KPI + graph APIs. */
  if(isTimesheetPage() && document.getElementById("kpi-submitted-val")){
    if(typeof syncDateUI==="function") syncDateUI();
    loadDashboardKPIs().then(function(){
      if(typeof window.tsAfterRender==="function") window.tsAfterRender();
    });
    return;
  }
  $("#page-"+state.page).innerHTML=PAGES[state.page]();
  $$("#page-"+state.page+" [data-drill]").forEach(el=>{
    if(el.dataset.drill)el.onclick=()=>drill(el.dataset.drill);
    el.onkeydown=e=>{if(e.key==="Enter"&&el.dataset.drill)drill(el.dataset.drill);};
  });
  bindHoursUI();
  requestAnimationFrame(drawCharts);
  whatIf();
  if(state.page==="timesheets"){
    loadDashboardKPIs().then(function(){
      if(typeof window.tsAfterRender==="function") window.tsAfterRender();
    });
  }else if(typeof initBlackTooltips==="function"){
    initBlackTooltips(document.getElementById("page-"+state.page)||document);
  }
}
const ROLES={
  ceo:{av:"VM",greet:"Good morning, Vishwas 👋",page:"exec",pm:null},
  dd:{av:"SU",greet:"Good morning, Saji 👋",page:"projects",pm:null},
  dm:{av:"AS",greet:"Good morning, Anwar 👋",page:"resources",pm:null},
  cfo:{av:"MD",greet:"Good morning, Mayuresh 👋",page:"finance",pm:null},
  cfo2:{av:"S",greet:"Good morning, Sambasivan 👋",page:"finance",pm:null},
  pm1:{av:"J",greet:"Good morning, Jagdish 👋",page:"projects",pm:"Jagdish"},
  pm2:{av:"N",greet:"Good morning, Nikhil 👋",page:"projects",pm:"Nikhil"},
  pm3:{av:"S",greet:"Good morning, Syamantak 👋",page:"projects",pm:"Syamantak"},
};
const ROLE_OPTIONS=[
  {value:"ceo",label:"CEO"},
  {value:"dd",label:"Delivery Director"},
  {value:"dm",label:"Delivery Manager"},
  {value:"cfo",label:"CFO"},
  {value:"cfo2",label:"CFO (Group)"},
  {value:"pm1",label:"Project Manager"}
];
function roleLabelFor(key){
  const o=ROLE_OPTIONS.find(x=>x.value===key);
  return o?o.label:"CEO";
}
function syncRolePill(){
  const sel=$("#roleSel");
  const key=(sel&&sel.value)||"ceo";
  const r=ROLES[key];
  const av=$("#roleAvatar"); if(r&&av) av.textContent=r.av;
  const lbl=$("#roleLabel"); if(lbl) lbl.textContent=roleLabelFor(key);
}
function applyRole(value){
  const r=ROLES[value];
  if(!r) return;
  const sel=$("#roleSel"); if(sel) sel.value=value;
  syncRolePill();
  state.filters["Project Manager"]=r.pm?[r.pm]:[];
  persistState();
  if(r.page!==CURRENT_PAGE){ location.href=r.page+".html"; return; }
  renderChips(); setPage(r.page);
  const g=$("#greet"); if(g)g.textContent=r.greet;
  toast("Persona switched — dashboard, filters & KPIs re-scoped to role");
}
function openRolePop(e){
  e.preventDefault();
  e.stopPropagation();
  closeMenus();
  const sel=$("#roleSel");
  const current=sel?sel.value:"ceo";
  const pop=document.createElement("div");
  pop.className="pop";
  pop.innerHTML=`<input class="search" placeholder="Search role…">
    <div class="pop-hd">Role · select</div>`+
    ROLE_OPTIONS.map(o=>`<button type="button" class="pop-item ${o.value===current?"sel":""}" data-v="${esc(o.value)}"><span class="box">${o.value===current?"✓":""}</span>${esc(o.label)}</button>`).join("");
  document.body.appendChild(pop);
  const r=(e.currentTarget||e.target).getBoundingClientRect();
  pop.style.position="fixed";
  pop.style.top=(r.bottom+6)+"px";
  pop.style.left=Math.min(r.left, innerWidth-250)+"px";
  pop.onclick=ev=>ev.stopPropagation();
  const search=pop.querySelector(".search");
  if(search){
    search.oninput=ev=>{
      const q=ev.target.value.toLowerCase();
      pop.querySelectorAll(".pop-item").forEach(it=>it.style.display=it.textContent.toLowerCase().includes(q)?"":"none");
    };
    setTimeout(()=>search.focus(),0);
  }
  pop.querySelectorAll(".pop-item").forEach(it=>it.onclick=()=>{
    applyRole(it.dataset.v);
    closeMenus();
  });
  setTimeout(()=>document.addEventListener("click",closeMenus,{once:true}));
}
if(!window.SKIP_APP_JS_BOOT){
const execRoleBtn=$("#execRoleBtn");
if(execRoleBtn) execRoleBtn.onclick=openRolePop;
const roleSel=$("#roleSel");
if(roleSel) roleSel.onchange=e=>applyRole(e.target.value);
const themeBtn=$("#themeBtn");
if(themeBtn)themeBtn.onclick=()=>{
  const t=document.documentElement.dataset.theme==="dark"?"light":"dark";
  document.documentElement.dataset.theme=t;
  persistState();
  renderPage(); toast(t==="dark"?"Dark mode":"Light mode");
};
}

/* =====================================================================
   CXO SAVED VIEWS (exec.html) — user-specific named filter snapshots
===================================================================== */
let execViewEditId = null;
let execInlineEditId = null;
function execReadStorage(store, keys){
  if(!store) return "";
  for(let i=0;i<keys.length;i++){
    try{
      const v=store.getItem(keys[i]);
      if(v && v!=="undefined" && v!=="null" && String(v).trim()) return String(v).trim();
    }catch(e){}
  }
  return "";
}
function execViewUserId(){
  const keys=["intUserID","EmployeeID","UserID","userid","LoginID","intLoginID","SessionEmployeeID"];
  let id=execReadStorage(window.sessionStorage, keys);
  if(!id){
    try{
      if(window.parent && window.parent!==window) id=execReadStorage(window.parent.sessionStorage, keys);
    }catch(e){}
  }
  if(id) return id;
  const role=$("#roleSel");
  if(role && role.value) return "role:"+role.value;
  return "guest";
}
function execViewsStorageKey(){
  const uid=execViewUserId();
  if(CURRENT_PAGE==="exec") return "whizible_exec_saved_views_v1_"+uid;
  return "whizible_"+CURRENT_PAGE+"_saved_views_v1_"+uid;
}
function execLoadViews(){
  try{
    const raw=localStorage.getItem(execViewsStorageKey());
    const parsed=raw?JSON.parse(raw):null;
    const list=Array.isArray(parsed)?parsed:(parsed && Array.isArray(parsed.views)?parsed.views:[]);
    const views=list.filter(v=>v && v.id && v.name);
    if(views.length) return views;
    if(CURRENT_PAGE!=="exec") return [];
    if(localStorage.getItem("whizible_exec_views_seeded_v1")) return [];
    return execSeedSampleViews();
  }catch(e){ return CURRENT_PAGE==="exec" ? execSeedSampleViews() : []; }
}
function execEmptyFilterMap(){
  const f={};
  Object.keys(FILTER_DEFS).forEach(k=>f[k]=[]);
  return f;
}
function execSampleSnapshot(opts){
  opts=opts||{};
  return {
    filters: Object.assign(execEmptyFilterMap(), opts.filters||{}),
    date: {
      label: opts.label||"Current Quarter",
      range: opts.range||"",
      months: opts.months||3,
      compare: opts.compare!==false,
      compareMode: opts.compareMode||"prev_dow",
      s: null,
      e: null,
      cs: null,
      ce: null
    }
  };
}
function execSeedSampleViews(){
  return [];
}
function execPersistViews(list){
  try{ localStorage.setItem(execViewsStorageKey(), JSON.stringify({userId:execViewUserId(), views:list})); }
  catch(e){ toast("Unable to store saved views on this browser"); }
}
function execCaptureSnapshot(){
  return {
    filters: JSON.parse(JSON.stringify(state.filters)),
    date: {
      label: state.date.label,
      range: state.date.range,
      months: state.date.months,
      compare: state.date.compare,
      compareMode: state.date.compareMode||"prev_dow",
      s: state.date.s ? new Date(state.date.s).toISOString() : null,
      e: state.date.e ? new Date(state.date.e).toISOString() : null,
      cs: state.date.cs ? new Date(state.date.cs).toISOString() : null,
      ce: state.date.ce ? new Date(state.date.ce).toISOString() : null
    }
  };
}
function execApplySnapshot(snap, opts){
  opts=opts||{};
  if(!snap) return false;
  Object.keys(state.filters).forEach(k=>state.filters[k]=[]);
  if(snap.filters){
    if(Array.isArray(snap.filters.Region) && (!snap.filters["Organization Unit"] || !snap.filters["Organization Unit"].length)){
      snap.filters["Organization Unit"]=snap.filters.Region;
    }
    Object.keys(FILTER_DEFS).forEach(k=>{
      const vals=snap.filters[k];
      state.filters[k]=Array.isArray(vals)?vals.slice():[];
    });
  }
  if(snap.date){
    Object.assign(state.date, snap.date);
    if(snap.date.s) state.date.s=new Date(snap.date.s);
    if(snap.date.e) state.date.e=new Date(snap.date.e);
    if(snap.date.cs) state.date.cs=new Date(snap.date.cs);
    if(snap.date.ce) state.date.ce=new Date(snap.date.ce);
    applyCompareDates(state.date);
  }
  refreshRelativeDateState();
  persistState();
  if(!opts.skipRender){
    renderChips(); syncDateUI(); renderPage();
  }
  return true;
}
function execGetDefaultView(list){
  const views=list||execLoadViews();
  return views.find(v=>v.isDefault)||null;
}
function execOpenOffcanvas(id){
  const el=document.getElementById(id);
  const bd=$("#execViewBackdrop");
  if(!el) return;
  el.classList.add("show");
  el.style.visibility="visible";
  if(bd){ bd.hidden=false; }
  document.body.style.overflow="hidden";
}
function execCloseOffcanvas(id){
  const ids=id?[id]:["execSavedViewsOffcanvas"];
  ids.forEach(ocId=>{
    const el=document.getElementById(ocId);
    if(el){ el.classList.remove("show"); el.style.visibility=""; }
  });
  const anyOpen=["execSavedViewsOffcanvas"].some(ocId=>{
    const el=document.getElementById(ocId);
    return el && el.classList.contains("show");
  });
  if(!anyOpen){
    const bd=$("#execViewBackdrop");
    if(bd) bd.hidden=true;
    document.body.style.overflow="";
  }
}
function execFilterSummaryRows(snap, opts){
  opts=opts||{};
  const filters=(snap && snap.filters)?snap.filters:state.filters;
  const date=(snap && snap.date)?snap.date:state.date;
  const rows=[];
  const periodVal=opts.periodLabelOnly
    ? (date && date.label)
    : [date && date.label, date && date.range].filter(Boolean).join(" · ");
  rows.push({label:"Period", values: periodVal? [periodVal] : ["Not set"]});
  if(date && date.compare) rows.push({label:"Compare", values:[compareModeMeta(date.compareMode).label]});
  Object.keys(FILTER_DEFS).forEach(k=>{
    const vals=filters && Array.isArray(filters[k])?filters[k].filter(Boolean):[];
    if(vals.length) rows.push({label:k, values:vals});
  });
  return rows;
}
function execFilterRowsHtml(snap){
  const rows=execFilterSummaryRows(snap, {periodLabelOnly:true});
  const dimRows=rows.filter(r=>r.label!=="Period" && r.label!=="Compare");
  return rows.map(r=>`<div class="exec-applied-row">
      <span class="exec-applied-k">${esc(r.label)}</span>
      <span class="exec-applied-v">${r.values.map(v=>`<span class="exec-applied-chip">${esc(v)}</span>`).join("")}</span>
    </div>`).join("")+(dimRows.length?"":'<div class="exec-applied-none">No additional filters applied</div>');
}
function execRenderAppliedFilters(snap){
  const host=$("#execAppliedFilters");
  if(!host) return;
  host.innerHTML=`<div class="exec-applied-title">Applied filters</div>`+execFilterRowsHtml(snap);
}
function execOpenSaveModal(){
  execViewEditId=null;
  const nameEl=$("#execViewName");
  const defEl=$("#execViewSetDefault");
  if(nameEl) nameEl.value="";
  if(defEl) defEl.checked=false;
  execRenderAppliedFilters(null);
  const wrap=$("#execSaveModal");
  if(wrap) wrap.hidden=false;
  document.body.style.overflow="hidden";
  setTimeout(()=>{ if(nameEl) nameEl.focus(); }, 50);
}
function execCloseSaveModal(){
  const wrap=$("#execSaveModal");
  if(wrap) wrap.hidden=true;
  const oc=$("#execSavedViewsOffcanvas");
  if(!(oc && oc.classList.contains("show"))) document.body.style.overflow="";
}
function execPeriodOptions(){
  return GA_PRESETS.filter(function(p){ return p[0]!=="Custom" && p[0]!=="divider"; }).map(function(p){ return p[0]; });
}
function execDateFromLabel(label, compare, compareMode){
  const preset=GA_PRESETS.find(function(p){ return p[0]===label; });
  const fn=preset && preset[1];
  let s=null, e=null, months=3, range="";
  if(typeof fn==="function"){
    const pair=fn();
    s=pair[0]; e=pair[1];
    range=rangeLbl(s,e);
    months=Math.max((Math.round((e-s)/864e5)+1)/30.42,0.1);
  }
  const mode=compare ? (compareMode||"prev_dow") : "prev_dow";
  let cs=null, ce=null;
  if(compare && s && e){
    const pair=computeCompareRange(s, e, mode);
    cs=pair[0]; ce=pair[1];
  }
  return {
    label: label||"Current Quarter",
    range, months, compare:!!compare, compareMode:mode,
    s: s? new Date(s).toISOString():null,
    e: e? new Date(e).toISOString():null,
    cs: cs? new Date(cs).toISOString():null,
    ce: ce? new Date(ce).toISOString():null
  };
}
function execMselLabel(selected){
  if(!selected || !selected.length) return "All";
  if(selected.length===1) return selected[0];
  return selected[0]+" +"+(selected.length-1);
}
function execDropdownHtml(field, options, selected, single){
  const sel=single ? (selected?[selected]:[]) : (Array.isArray(selected)?selected:[]);
  const label=single ? (selected || options[0] || "") : execMselLabel(sel);
  const items=single
    ? options.map(o=>`<button type="button" class="exec-msel-opt${o===selected?" sel":""}" data-value="${esc(o)}">${esc(o)}</button>`).join("")
    : options.map(o=>`<label class="exec-msel-item"><input type="checkbox" value="${esc(o)}"${sel.includes(o)?" checked":""}><span>${esc(o)}</span></label>`).join("");
  return `<div class="exec-msel" data-edit-field="${esc(field)}" data-single="${single?"1":"0"}">
    <button type="button" class="exec-msel-btn" title="${esc(single?label:(sel.join(", ")||"All"))}">${esc(label)} <i class="fas fa-chevron-down"></i></button>
    <div class="exec-msel-panel" hidden data-panel-for="${esc(field)}">${items}</div>
  </div>`;
}
function execFilterEditorHtml(snap){
  const filters=(snap && snap.filters)?snap.filters:{};
  const date=(snap && snap.date)?snap.date:{};
  const period=date.label||"Current Quarter";
  const compare=!!date.compare;
  const compareSel=compare ? compareModeMeta(date.compareMode).label : "Off";
  const compareOpts=["Off"].concat(GA_COMPARE_MODES.map(m=>m.label));
  const periodOpts=execPeriodOptions();
  if(period && periodOpts.indexOf(period)<0) periodOpts.unshift(period);
  let html=`<div class="exec-applied-row"><span class="exec-applied-k">Period</span><span class="exec-applied-v">${execDropdownHtml("period", periodOpts, period, true)}</span></div>`;
  html+=`<div class="exec-applied-row"><span class="exec-applied-k">Compare</span><span class="exec-applied-v">${execDropdownHtml("compare", compareOpts, compareSel, true)}</span></div>`;
  Object.keys(FILTER_DEFS).forEach(k=>{
    html+=`<div class="exec-applied-row"><span class="exec-applied-k">${esc(k)}</span><span class="exec-applied-v">${execDropdownHtml(k, FILTER_DEFS[k], filters[k]||[], false)}</span></div>`;
  });
  return html;
}
function execCloseMselPanels(){
  document.querySelectorAll(".exec-msel-panel").forEach(panel=>{
    panel.hidden=true;
    panel.classList.remove("open");
    panel.style.top="";
    panel.style.left="";
    panel.style.width="";
    const field=panel.getAttribute("data-panel-for");
    const ms=document.querySelector('.exec-msel[data-edit-field="'+field+'"]');
    if(ms && panel.parentElement!==ms) ms.appendChild(panel);
  });
}
function execBindFilterEditors(card){
  if(!card) return;
  card.querySelectorAll(".exec-msel").forEach(ms=>{
    const btn=ms.querySelector(".exec-msel-btn");
    const panel=ms.querySelector(".exec-msel-panel");
    if(!btn || !panel) return;
    btn.onclick=e=>{
      e.preventDefault();
      e.stopPropagation();
      const wasHidden=panel.hidden;
      execCloseMselPanels();
      if(!wasHidden) return;
      document.body.appendChild(panel);
      panel.hidden=false;
      panel.classList.add("open");
      const r=btn.getBoundingClientRect();
      const width=Math.max(r.width, 200);
      let left=r.left;
      if(left+width>window.innerWidth-8) left=Math.max(8, window.innerWidth-width-8);
      let top=r.bottom+2;
      panel.style.position="fixed";
      panel.style.zIndex="6000";
      panel.style.width=width+"px";
      panel.style.left=left+"px";
      panel.style.top=top+"px";
      const ph=panel.offsetHeight;
      if(top+ph>window.innerHeight-8 && r.top>ph+8){
        panel.style.top=(r.top-ph-2)+"px";
      }
    };
    panel.onclick=e=>e.stopPropagation();
    if(ms.dataset.single==="1"){
      panel.querySelectorAll(".exec-msel-opt").forEach(opt=>{
        opt.onclick=e=>{
          e.preventDefault();
          e.stopPropagation();
          panel.querySelectorAll(".exec-msel-opt").forEach(o=>o.classList.remove("sel"));
          opt.classList.add("sel");
          const val=opt.getAttribute("data-value")||"";
          btn.innerHTML=esc(val)+' <i class="fas fa-chevron-down"></i>';
          btn.title=val;
          execCloseMselPanels();
        };
      });
    }else{
      panel.querySelectorAll("input[type=checkbox]").forEach(cb=>{
        cb.onchange=()=>{
          const selected=[...panel.querySelectorAll("input:checked")].map(i=>i.value);
          btn.innerHTML=esc(execMselLabel(selected))+' <i class="fas fa-chevron-down"></i>';
          btn.title=selected.join(", ")||"All";
        };
      });
    }
  });
  if(!window._execMselDocBound){
    document.addEventListener("click", execCloseMselPanels);
    window._execMselDocBound=true;
  }
}
function execReadEditorSnapshot(card){
  execCloseMselPanels();
  function btnText(el){
    if(!el) return "";
    const clone=el.cloneNode(true);
    clone.querySelectorAll("i").forEach(i=>i.remove());
    return clone.textContent.trim();
  }
  const periodMs=card.querySelector('.exec-msel[data-edit-field="period"]');
  const compareMs=card.querySelector('.exec-msel[data-edit-field="compare"]');
  const periodVal=btnText(periodMs && periodMs.querySelector(".exec-msel-btn"))||"Current Quarter";
  const compareVal=btnText(compareMs && compareMs.querySelector(".exec-msel-btn"));
  const compareOn=compareVal && compareVal!=="Off";
  const compareMode=(GA_COMPARE_MODES.find(m=>m.label===compareVal)||{}).id || "prev_dow";
  const filters=execEmptyFilterMap();
  card.querySelectorAll(".exec-msel").forEach(ms=>{
    const field=ms.dataset.editField;
    if(!field || field==="period" || field==="compare") return;
    const panel=ms.querySelector(".exec-msel-panel");
    filters[field]=panel?[...panel.querySelectorAll("input:checked")].map(i=>i.value):[];
  });
  return { filters, date: execDateFromLabel(periodVal, compareOn, compareMode) };
}
function execStartInlineEdit(id){
  execCloseMselPanels();
  execInlineEditId=id;
  execRenderSavedViewsList();
}
function execCancelInlineEdit(){
  execCloseMselPanels();
  execInlineEditId=null;
  execRenderSavedViewsList();
}
function execSaveInlineEdit(id){
  const card=document.querySelector('.exec-view-row[data-view-id="'+id+'"]');
  if(!card) return;
  const nameEl=card.querySelector(".exec-inline-name");
  const defEl=card.querySelector(".exec-inline-default");
  const name=(nameEl && nameEl.value?nameEl.value:"").trim();
  if(!name){
    toast("Please enter a filter view name");
    if(nameEl) nameEl.focus();
    return;
  }
  const views=execLoadViews();
  const dup=views.find(v=>v.name.toLowerCase()===name.toLowerCase() && v.id!==id);
  if(dup){
    toast("A view with this name already exists");
    if(nameEl) nameEl.focus();
    return;
  }
  const existing=views.find(v=>v.id===id);
  if(!existing){
    toast("That view is no longer available");
    return;
  }
  const setDefault=!!(defEl && defEl.checked);
  if(setDefault) views.forEach(v=>v.isDefault=false);
  existing.name=name;
  existing.isDefault=setDefault;
  existing.snapshot=execReadEditorSnapshot(card);
  existing.updatedAt=new Date().toISOString();
  execPersistViews(views);
  execInlineEditId=null;
  execSyncDefaultBtn();
  execRenderSavedViewsList();
  toast(setDefault?'View updated and set as default':'View updated');
}
function execRenderSavedViewsList(){
  const host=$("#execSavedViewsList");
  if(!host) return;
  const views=execLoadViews();
  if(!views.length){
    host.innerHTML='<div class="exec-view-empty">No saved views yet. Select filters and click Save View.</div>';
    return;
  }
  host.innerHTML=views.map(v=>{
    const editing=execInlineEditId===v.id;
    const filtersHtml=`<div class="exec-applied exec-view-applied">${execFilterRowsHtml(v.snapshot)}</div>`;
    if(editing){
      return `<div class="exec-view-row is-editing ${v.isDefault?"is-default":""}" data-view-id="${esc(v.id)}">
        <label class="exec-oc-label">Filter View Name</label>
        <input type="text" class="form-control exec-oc-input exec-inline-name" maxlength="80" value="${esc(v.name)}" autocomplete="off">
        <div class="exec-applied exec-view-applied">${execFilterEditorHtml(v.snapshot)}</div>
        <label class="exec-oc-check"><input type="checkbox" class="exec-inline-default"${v.isDefault?" checked":""}><span>Set as Default</span></label>
        <div class="exec-oc-actions">
          <button type="button" class="ghostbtn exec-oc-primary" data-exec-inline-save="${esc(v.id)}">Save</button>
          <button type="button" class="ghostbtn" data-exec-inline-cancel>Cancel</button>
        </div>
      </div>`;
    }
    return `<div class="exec-view-row ${v.isDefault?"is-default":""}">
      <div class="exec-view-head">
        <button type="button" class="exec-view-name" data-exec-apply="${esc(v.id)}" title="Apply this view">${esc(v.name)}</button>
        <label class="exec-view-default">
          <input type="checkbox" data-exec-default="${esc(v.id)}"${v.isDefault?" checked":""}>
          <span>Set as Default</span>
        </label>
        <button type="button" class="exec-view-ico" data-exec-edit="${esc(v.id)}" title="Edit"><i class="fas fa-pen"></i></button>
        <button type="button" class="exec-view-ico danger" data-exec-delete="${esc(v.id)}" title="Delete"><i class="far fa-trash-alt"></i></button>
      </div>
      ${filtersHtml}
    </div>`;
  }).join("");
  host.querySelectorAll("[data-exec-apply]").forEach(btn=>{
    btn.onclick=()=>{
      const view=execLoadViews().find(v=>v.id===btn.dataset.execApply);
      if(!view) return;
      execApplySnapshot(view.snapshot);
      toast('View "'+view.name+'" applied');
      execCloseOffcanvas();
    };
  });
  host.querySelectorAll("[data-exec-edit]").forEach(btn=>{
    btn.onclick=()=>execStartInlineEdit(btn.dataset.execEdit);
  });
  host.querySelectorAll("[data-exec-default]").forEach(cb=>{
    cb.onchange=()=>execToggleViewDefault(cb.dataset.execDefault, cb.checked);
  });
  host.querySelectorAll("[data-exec-inline-save]").forEach(btn=>{
    btn.onclick=()=>execSaveInlineEdit(btn.dataset.execInlineSave);
  });
  host.querySelectorAll("[data-exec-inline-cancel]").forEach(btn=>{
    btn.onclick=execCancelInlineEdit;
  });
  const editCard=host.querySelector(".exec-view-row.is-editing");
  if(editCard) execBindFilterEditors(editCard);
  host.querySelectorAll("[data-exec-delete]").forEach(btn=>{
    btn.onclick=()=>{
      const id=btn.dataset.execDelete;
      const views=execLoadViews();
      const view=views.find(v=>v.id===id);
      if(!view) return;
      if(!confirm('Delete saved view "'+view.name+'"?')) return;
      if(execInlineEditId===id) execInlineEditId=null;
      execPersistViews(views.filter(v=>v.id!==id));
      toast("View deleted");
      execRenderSavedViewsList();
      execSyncDefaultBtn();
    };
  });
  const inlineName=host.querySelector(".exec-inline-name");
  if(inlineName){
    inlineName.focus();
    inlineName.addEventListener("keydown", e=>{
      if(e.key==="Enter"){ e.preventDefault(); execSaveInlineEdit(execInlineEditId); }
    });
  }
}
function execUniqueViewName(base){
  const names=execLoadViews().map(v=>(v.name||"").toLowerCase());
  let name=(base||"View").trim().slice(0,70);
  if(!name) name="View";
  if(!names.includes(name.toLowerCase())) return name;
  let i=2;
  while(names.includes((name+" ("+i+")").toLowerCase())) i++;
  return name+" ("+i+")";
}
function execAutoViewName(){
  const rows=execFilterSummaryRows(null);
  const period=(state.date && state.date.label) || "View";
  const dims=rows.filter(r=>r.label!=="Period" && r.label!=="Compare");
  const extra=dims.map(r=>r.values.join(", ")).join(" · ");
  return extra? period+" · "+extra : period;
}
function execSaveDirectly(){
  const snapshot=execCaptureSnapshot();
  const views=execLoadViews();
  const now=new Date().toISOString();
  const name=execUniqueViewName(execAutoViewName());
  views.push({
    id:"v_"+Date.now().toString(36)+Math.random().toString(36).slice(2,7),
    name, isDefault:false, snapshot, createdAt:now, updatedAt:now
  });
  execPersistViews(views);
  execSyncDefaultBtn();
  toast('View "'+name+'" saved');
}
function execSetViewAsDefault(id){
  execToggleViewDefault(id, true);
}
function execToggleViewDefault(id, on){
  const views=execLoadViews();
  const view=views.find(v=>v.id===id);
  if(!view) return;
  if(on){
    views.forEach(v=>v.isDefault=(v.id===id));
    toast('"'+view.name+'" set as default');
  } else {
    view.isDefault=false;
    toast('Default removed from "'+view.name+'"');
  }
  execPersistViews(views);
  execSyncDefaultBtn();
  execRenderSavedViewsList();
}
function execSyncDefaultBtn(){
  const btn=$("#execDefaultViewBtn");
  if(!btn) return;
  const def=execGetDefaultView();
  btn.title=def?('Apply default view: '+def.name):"No default view is set. Open My Views and set one as default.";
}
function execSaveCurrentView(){
  const nameEl=$("#execViewName");
  const defEl=$("#execViewSetDefault");
  const name=(nameEl && nameEl.value?nameEl.value:"").trim();
  if(!name){
    toast("Please enter a filter name");
    if(nameEl) nameEl.focus();
    return;
  }
  let views=execLoadViews();
  const dup=views.find(v=>v.name.toLowerCase()===name.toLowerCase() && v.id!==execViewEditId);
  if(dup){
    toast("A view with this name already exists");
    if(nameEl) nameEl.focus();
    return;
  }
  const setDefault=!!(defEl && defEl.checked);
  if(setDefault) views.forEach(v=>v.isDefault=false);
  const now=new Date().toISOString();
  const snapshot=execCaptureSnapshot();
  if(execViewEditId){
    const existing=views.find(v=>v.id===execViewEditId);
    if(!existing){
      toast("That view is no longer available");
      return;
    }
    existing.name=name;
    existing.isDefault=setDefault;
    existing.snapshot=snapshot;
    existing.updatedAt=now;
  }else{
    views.push({
      id:"v_"+Date.now().toString(36)+Math.random().toString(36).slice(2,7),
      name, isDefault:setDefault, snapshot, createdAt:now, updatedAt:now
    });
  }
  execPersistViews(views);
  execCloseSaveModal();
  execSyncDefaultBtn();
  toast(setDefault?'View saved and set as default':'View saved');
}
function execApplyDefaultView(){
  const def=execGetDefaultView();
  if(!def){
    toast("No default view is set. Save a view and check Set as Default.");
    return;
  }
  execApplySnapshot(def.snapshot);
  toast('Default view "'+def.name+'" applied');
}
function execOpenMyViews(){
  execRenderSavedViewsList();
  execOpenOffcanvas("execSavedViewsOffcanvas");
}
//  Modify By Madhuri.K on 01-10-2026 
/* =====================================================================
   Save View / My Views — API (same as PM_AnalyticsCXO_Dashboard.aspx)
   SaveUserFilter / GetUserFilter / SetDefaultUserFilter / DeleteUserFilter
   Used when filter API + SessionEmployeeID are available (Timesheet, etc.).
===================================================================== */
var UserViewEditId=null;
var UserViewsCache=[];
var UserViewInlineEditId=null;
var AppliedUserFilterId=null;
var PendingDeleteUserFilterId=null;
var PendingDeleteFilterName="";
var _uvMselDocBound=false;

function canUseUserFilterApis(){
  const sid=getSessionEmployeeId();
  if(!sid) return false;
  if(canUseFilterApis()) return true;
  return !!(typeof window!=="undefined" && typeof window.callDashboardApi==="function");
}
function getSessionEmployeeId(){
  const raw=(typeof window!=="undefined" && window.SessionEmployeeID!=null)?window.SessionEmployeeID
    :(typeof SessionEmployeeID!=="undefined"?SessionEmployeeID:"");
  const s=String(raw||"").trim();
  return s && s!=="0" ? s : "";
}
function getApiField(row){
  return getFilterField.apply(null, arguments);
}
function showAlertError(msg){
  if(typeof alertify!=="undefined"){
    try{ alertify.set("notifier","position","top-right"); }catch(e){}
    alertify.error(msg||"Something went wrong");
    return;
  }
  toast(msg||"Something went wrong");
}
function showAlertSuccess(msg){
  if(typeof alertify!=="undefined"){
    try{ alertify.set("notifier","position","top-right"); }catch(e){}
    alertify.success(msg||"Done");
    return;
  }
  toast(msg||"Done");
}
function afterUserFilterApply(opts, onDone){
  opts=opts||{};
  syncTopFilterToAppState();
  function paintChips(){
    if(typeof window!=="undefined" && typeof window.syncTopFilterChipBadges==="function") window.syncTopFilterChipBadges();
    else if(typeof syncTopFilterChipBadges==="function") syncTopFilterChipBadges();
    else if(typeof window!=="undefined" && typeof window.RenderTopFilterChips==="function") window.RenderTopFilterChips();
    else if(typeof RenderTopFilterChips==="function") RenderTopFilterChips();
    else if(typeof renderChips==="function") renderChips();
  }
  paintChips();
  persistState();
  const finish=function(){
    syncTopFilterToAppState();
    paintChips();
    persistState();
    if(!opts.skipRender){
      if(typeof window!=="undefined" && typeof window.RefreshKpiDashboard==="function") window.RefreshKpiDashboard();
      else if(typeof RefreshKpiDashboard==="function") RefreshKpiDashboard();
      else if(typeof renderPage==="function") renderPage();
    }
    if(onDone) onDone();
  };
  if(canUseFilterApis() && TopFilter.loaded){
    LoadDependentTopFilters(joinSelectedIds("Portfolio"), finish);
  }else if(isTimesheetPage()){
    reloadTimesheetProjectManagers(finish);
  }else finish();
}
function applyUserFilterChips(filterJson, opts){
  opts=opts||{};
  const selected=parseUserFilterChips(filterJson);
  TOP_FILTER_CHIPS.forEach(chip=>{
    const raw=selected[chip.label]||[];
    const optsList=TopFilter.options[chip.label]||TopFilter.options[chip.flag]||[];
    writeTopFilterSelected(chip.label, resolveSelectedAgainstOptions(chip.label, raw, optsList));
  });
  afterUserFilterApply({skipRender:!!opts.skipRender||!!opts.skipKpi}, function(){
    if(opts.onDone) opts.onDone();
  });
}
function clearAppliedUserFilterChips(opts){
  opts=opts||{};
  AppliedUserFilterId=null;
  clearTopFilterSelections();
  afterUserFilterApply({skipRender:!!opts.skipRender||!!opts.skipKpi}, function(){
    if(opts.onDone) opts.onDone();
  });
}
function mselButtonLabel(selected){
  if(!selected||!selected.length) return "All";
  if(selected.length===1) return selected[0].name||selected[0];
  return (selected[0].name||selected[0])+" +"+(selected.length-1);
}
function buildMultiSelectDropdownHtml(field, options, selected){
  const sel=Array.isArray(selected)?selected:[];
  const resolved=resolveSelectedAgainstOptions(field, sel, options||[]);
  const selIds={};
  resolved.forEach(x=>{ selIds[String(x.id)]=true; });
  if(field==="Health"){
    resolved.forEach(x=>{
      const n=normalizeHealthFilterId(x.id);
      if(n) selIds[n]=true;
      selIds[String(x.name||"").toLowerCase()]=true;
    });
  }
  let items="";
  (options||[]).forEach(o=>{
    let on=!!selIds[String(o.id)];
    if(!on && field==="Health"){
      on=!!selIds[normalizeHealthFilterId(o.id)] || !!selIds[String(o.name||"").toLowerCase()];
    }
    items+='<label class="exec-msel-item"><input type="checkbox" value="'+esc(o.id)+'" data-name="'+esc(o.name)+'"'+(on?" checked":"")+'>'+
      '<span>'+esc(o.name)+'</span></label>';
  });
  if(!options||!options.length) items='<div class="exec-applied-none" style="padding:8px">No options</div>';
  return '<div class="exec-msel" data-edit-field="'+esc(field)+'">'+
    '<button type="button" class="exec-msel-btn" title="'+esc(resolved.map(x=>x.name).join(", ")||"All")+'">'+
    esc(mselButtonLabel(resolved))+' <i class="fas fa-chevron-down"></i></button>'+
    '<div class="exec-msel-panel" hidden data-panel-for="'+esc(field)+'">'+items+'</div></div>';
}
function buildInlineFilterEditorHtml(selectedMap){
  let html="";
  selectedMap=selectedMap||{};
  TOP_FILTER_CHIPS.forEach(chip=>{
    const opts=(TopFilter.options&&TopFilter.options[chip.label])||[];
    const sel=selectedMap[chip.label]||[];
    html+='<div class="exec-applied-row"><span class="exec-applied-k">'+esc(chip.label)+'</span>'+
      '<span class="exec-applied-v">'+buildMultiSelectDropdownHtml(chip.label, opts, sel)+'</span></div>';
  });
  return html;
}
function closeInlineMselPanels(){
  document.querySelectorAll(".exec-msel-panel").forEach(panel=>{
    panel.hidden=true;
    panel.classList.remove("open");
    panel.style.top=""; panel.style.left=""; panel.style.width="";
    const field=panel.getAttribute("data-panel-for");
    const ms=document.querySelector('.exec-msel[data-edit-field="'+field+'"]');
    if(ms && panel.parentElement!==ms) ms.appendChild(panel);
  });
}
function bindInlineMultiSelectEditors(card){
  if(!card) return;
  card.querySelectorAll(".exec-msel").forEach(ms=>{
    const btn=ms.querySelector(".exec-msel-btn");
    const panel=ms.querySelector(".exec-msel-panel");
    if(!btn||!panel) return;
    btn.onclick=function(e){
      e.preventDefault(); e.stopPropagation();
      const wasHidden=panel.hidden;
      closeInlineMselPanels();
      if(!wasHidden) return;
      document.body.appendChild(panel);
      panel.hidden=false; panel.classList.add("open");
      const r=btn.getBoundingClientRect();
      const width=Math.max(r.width,200);
      let left=r.left;
      if(left+width>window.innerWidth-8) left=Math.max(8, window.innerWidth-width-8);
      let top=r.bottom+2;
      panel.style.position="fixed"; panel.style.zIndex="6000";
      panel.style.width=width+"px"; panel.style.left=left+"px"; panel.style.top=top+"px";
      const ph=panel.offsetHeight;
      if(top+ph>window.innerHeight-8 && r.top>ph+8) panel.style.top=(r.top-ph-2)+"px";
    };
    panel.onclick=function(e){ e.stopPropagation(); };
    panel.querySelectorAll("input[type=checkbox]").forEach(cb=>{
      cb.onchange=function(){
        const selected=[];
        panel.querySelectorAll("input:checked").forEach(i=>{
          selected.push({id:i.value, name:i.getAttribute("data-name")||i.value});
        });
        btn.innerHTML=esc(mselButtonLabel(selected))+' <i class="fas fa-chevron-down"></i>';
        btn.setAttribute("title", selected.map(x=>x.name).join(", ")||"All");
      };
    });
  });
  if(!_uvMselDocBound){
    document.addEventListener("click", closeInlineMselPanels);
    _uvMselDocBound=true;
  }
}
function readInlineFilterEditor(card){
  const selected={};
  TOP_FILTER_CHIPS.forEach(chip=>{ selected[chip.label]=[]; });
  if(!card) return selected;
  closeInlineMselPanels();
  card.querySelectorAll(".exec-msel").forEach(ms=>{
    const field=ms.getAttribute("data-edit-field");
    const panel=document.querySelector('.exec-msel-panel[data-panel-for="'+field+'"]')||ms.querySelector(".exec-msel-panel");
    const list=[];
    if(!field||!panel) return;
    panel.querySelectorAll("input:checked").forEach(inp=>{
      list.push({id:String(inp.value), name:String(inp.getAttribute("data-name")||inp.value)});
    });
    selected[field]=list;
  });
  return selected;
}
function buildUserFilterJsonFromMap(selectedMap){
  const chips={};
  TOP_FILTER_CHIPS.forEach(chip=>{
    const arr=(selectedMap&&(selectedMap[chip.label]||selectedMap[chip.flag]))||[];
    chips[chip.flag]=arr.map(x=>({id:String(x.id), name:String(x.name)}));
  });
  return JSON.stringify({chips:chips});
}
function buildUserFilterJson(){
  const map=collectTopFilterSelectionMap();
  /* Persist resolved map back so chip UI / KPI stay in sync with what we save. */
  TOP_FILTER_CHIPS.forEach(chip=>{ writeTopFilterSelected(chip.label, map[chip.label]||[]); });
  syncTopFilterToAppState();
  return buildUserFilterJsonFromMap(map);
}
function parseUserFilterChips(filterJson){
  const selected={};
  TOP_FILTER_CHIPS.forEach(chip=>{ selected[chip.label]=[]; });
  if(!filterJson) return selected;
  let bag;
  try{ bag=typeof filterJson==="string"?JSON.parse(filterJson):filterJson; }
  catch(e){ return selected; }
  bag=(bag&&bag.chips)?bag.chips:(bag&&bag.filters)?bag.filters:bag;
  if(!bag||typeof bag!=="object") return selected;
  TOP_FILTER_CHIPS.forEach(chip=>{
    const key=Object.keys(bag).find(k=>
      String(k).replace(/\s/g,"").toLowerCase()===chip.flag.toLowerCase()
      || String(k).replace(/\s/g,"").toLowerCase()===String(chip.label).replace(/\s/g,"").toLowerCase()
      || String(k).toLowerCase()===chip.label.toLowerCase()
    );
    let rows=key?bag[key]:[];
    if(!Array.isArray(rows)) rows=[];
    const list=[];
    rows.forEach(r=>{
      if(r==null) return;
      if(typeof r==="string"){ list.push({id:r, name:r}); return; }
      const id=r.id!=null?r.id:(r.ID!=null?r.ID:r.Id);
      const name=r.name!=null?r.name:(r.Name!=null?r.Name:id);
      if(id!=null && name!=null) list.push({id:String(id), name:String(name)});
    });
    const optsList=TopFilter.options[chip.label]||TopFilter.options[chip.flag]||[];
    selected[chip.label]=resolveSelectedAgainstOptions(chip.label, list, optsList);
  });
  return selected;
}
function findUserViewById(userFilterId){
  const id=String(userFilterId||"");
  if(!id) return null;
  return (UserViewsCache||[]).find(v=>String(getApiField(v,"UserFilterID"))===id)||null;
}
function reloadMyViewsList(onDone){
  LoadUserViews(function(list){
    const oc=document.getElementById("execSavedViewsOffcanvas");
    if((oc&&oc.classList.contains("show"))||document.getElementById("execSavedViewsList"))
      RenderMyViewsList(list);
    if(onDone) onDone(list);
  });
}
function applyViewActionToPage(opts){
  opts=opts||{};
  function afterFilters(){
    reloadMyViewsList(function(){
      if(typeof window!=="undefined" && typeof window.RefreshKpiDashboard==="function") window.RefreshKpiDashboard();
      else if(typeof RefreshKpiDashboard==="function") RefreshKpiDashboard();
      else if(typeof renderPage==="function") renderPage();
      if(opts.onDone) opts.onDone();
    });
  }
  if(opts.clearFilters){
    clearAppliedUserFilterChips({skipKpi:true, onDone:afterFilters});
  }else if(opts.filterJson!=null){
    applyUserFilterChips(opts.filterJson, {
      skipKpi:true,
      onDone:function(){
        if(opts.userFilterId!=null) AppliedUserFilterId=String(opts.userFilterId);
        afterFilters();
      }
    });
  }else afterFilters();
}
function buildAppliedMultiFiltersHtml(selectedMap){
  let html="";
  selectedMap=selectedMap||TopFilter.selected;
  TOP_FILTER_CHIPS.forEach(chip=>{
    const arr=selectedMap[chip.label]||[];
    if(!arr.length) return;
    const names=arr.map(x=>x.name||x);
    html+='<div class="exec-applied-row"><span class="exec-applied-k">'+esc(chip.label)+'</span><span class="exec-applied-v">'+
      names.map(n=>'<span class="exec-applied-chip">'+esc(n)+'</span>').join("")+
      '</span></div>';
  });
  if(!html) html='<div class="exec-applied-none">No multi-select filters applied</div>';
  return html;
}
function renderSaveViewAppliedFilters(selectedMap){
  const host=document.getElementById("execAppliedFilters");
  if(!host) return;
  host.innerHTML='<div class="exec-applied-title">Applied filters</div>'+buildAppliedMultiFiltersHtml(selectedMap);
}
function OpenSaveViewModal(editRow){
  const nameEl=document.getElementById("execViewName");
  const defEl=document.getElementById("execViewSetDefault");
  const wrap=document.getElementById("execSaveModal");
  UserViewEditId=null;
  if(editRow){
    UserViewEditId=Number(getApiField(editRow,"UserFilterID"))||null;
    if(nameEl) nameEl.value=String(getApiField(editRow,"FilterName")||"");
    if(defEl){
      const d=getApiField(editRow,"IsDefaultFilter");
      defEl.checked=d===true||d===1||String(d).toLowerCase()==="true";
    }
    applyUserFilterChips(getApiField(editRow,"FilterJson"), {
      skipKpi:true,
      onDone:function(){ renderSaveViewAppliedFilters(collectTopFilterSelectionMap()); }
    });
  }else{
    if(nameEl) nameEl.value="";
    if(defEl) defEl.checked=false;
    renderSaveViewAppliedFilters(collectTopFilterSelectionMap());
  }
  if(wrap) wrap.hidden=false;
  document.body.style.overflow="hidden";
  setTimeout(function(){ if(nameEl) nameEl.focus(); },50);
}
function CloseSaveViewModal(){
  const wrap=document.getElementById("execSaveModal");
  const oc=document.getElementById("execSavedViewsOffcanvas");
  if(wrap) wrap.hidden=true;
  UserViewEditId=null;
  if(!(oc&&oc.classList.contains("show"))) document.body.style.overflow="";
}
function SaveUserView(){
  const nameEl=document.getElementById("execViewName");
  const defEl=document.getElementById("execViewSetDefault");
  const name=(nameEl&&nameEl.value?nameEl.value:"").trim();
  const sid=getSessionEmployeeId();
  if(!sid){ showAlertError("Session expired. Please login again."); return; }
  if(!name){ showAlertError("Filter View Name is mandatory."); if(nameEl) nameEl.focus(); return; }
  const body={
    DashboardID:getDashboardId(),
    SessionEmployeeID:String(sid),
    FilterName:name,
    FilterJson:buildUserFilterJson(),
    IsDefaultFilter:!!(defEl&&defEl.checked)
  };
  if(UserViewEditId) body.UserFilterID=UserViewEditId;
  callUserFilterApi("SaveUserFilter", body, function(json){
    const rows=getApiRows(json,"AnalyticsDBUserFilterModel");
    if(!rows||!rows.length){
      showAlertError((json&&(json.message||json.Message))||"Unable to save view.");
      return;
    }
    const savedId=getApiField(rows[0],"UserFilterID")||body.UserFilterID||null;
    CloseSaveViewModal();
    showAlertSuccess(body.UserFilterID?"View Updated Successfully":"View Saved Successfully");
    applyViewActionToPage({filterJson:body.FilterJson, userFilterId:savedId});
  }, function(){ showAlertError("Unable to save view. Please try again."); });
}
function LoadUserViews(onDone){
  const sid=getSessionEmployeeId();
  if(!sid){ UserViewsCache=[]; if(onDone) onDone([]); return; }
  callUserFilterApi("GetUserFilter", {
    DashboardID:getDashboardId(),
    SessionEmployeeID:String(sid),
    GetDefaultOnly:false
  }, function(json){
    UserViewsCache=getApiRows(json,"AnalyticsDBUserFilterModel")||[];
    if(onDone) onDone(UserViewsCache);
  }, function(){ UserViewsCache=[]; if(onDone) onDone([]); });
}
function LoadDefaultUserView(onDone){
  const sid=getSessionEmployeeId();
  if(!sid){ if(onDone) onDone(null); return; }
  callUserFilterApi("GetUserFilter", {
    DashboardID:getDashboardId(),
    SessionEmployeeID:String(sid),
    GetDefaultOnly:true
  }, function(json){
    const rows=getApiRows(json,"AnalyticsDBUserFilterModel")||[];
    const row=rows[0]||null;
    if(row){
      AppliedUserFilterId=String(getApiField(row,"UserFilterID")||"");
      applyUserFilterChips(getApiField(row,"FilterJson"), {
        skipKpi:true,
        onDone:function(){ if(onDone) onDone(row); }
      });
      return;
    }
    if(onDone) onDone(row);
  }, function(){ if(onDone) onDone(null); });
}
function SetUserViewDefault(userFilterId, isDefault){
  const sid=getSessionEmployeeId();
  if(!sid||!userFilterId) return;
  const view=findUserViewById(userFilterId);
  callUserFilterApi("SetDefaultUserFilter", {
    DashboardID:getDashboardId(),
    SessionEmployeeID:String(sid),
    UserFilterID:Number(userFilterId),
    IsDefaultFilter:!!isDefault
  }, function(json){
    const rows=getApiRows(json,"AnalyticsDBUserFilterModel");
    if(!rows||!rows.length){
      showAlertError("Unable to update default view.");
      RenderMyViewsList(UserViewsCache);
      return;
    }
    showAlertSuccess(isDefault?"Default View Set as Default Successfully":"Default View removed Successfully");
    if(isDefault){
      applyViewActionToPage({
        filterJson:view?getApiField(view,"FilterJson"):null,
        userFilterId:userFilterId
      });
    }else applyViewActionToPage({clearFilters:true});
  }, function(){
    showAlertError("Unable to update default view.");
    reloadMyViewsList();
  });
}
function OpenDeleteFilterModal(userFilterId, filterName){
  const wrap=document.getElementById("execDeleteFilterModal");
  const msg=document.getElementById("execDeleteFilterMsg");
  PendingDeleteUserFilterId=userFilterId?String(userFilterId):null;
  PendingDeleteFilterName=filterName||"";
  if(msg) msg.textContent="Do you want to delete this filter?";
  if(wrap) wrap.hidden=false;
  document.body.style.overflow="hidden";
}
function CloseDeleteFilterModal(){
  const wrap=document.getElementById("execDeleteFilterModal");
  const oc=document.getElementById("execSavedViewsOffcanvas");
  if(wrap) wrap.hidden=true;
  PendingDeleteUserFilterId=null;
  PendingDeleteFilterName="";
  if(!(oc&&oc.classList.contains("show"))) document.body.style.overflow="";
}
function ConfirmDeleteUserView(){
  const userFilterId=PendingDeleteUserFilterId;
  const sid=getSessionEmployeeId();
  if(!sid||!userFilterId){ CloseDeleteFilterModal(); return; }
  const view=findUserViewById(userFilterId);
  const wasApplied=AppliedUserFilterId&&String(AppliedUserFilterId)===String(userFilterId);
  const d=view?getApiField(view,"IsDefaultFilter"):null;
  const wasDefault=!!(d===true||d===1||String(d).toLowerCase()==="true");
  callUserFilterApi("DeleteUserFilter", {
    DashboardID:getDashboardId(),
    SessionEmployeeID:String(sid),
    UserFilterID:Number(userFilterId)
  }, function(json){
    const rows=getApiRows(json,"AnalyticsDBUserFilterModel");
    CloseDeleteFilterModal();
    if(!rows||!rows.length){ showAlertError("Unable to delete view."); return; }
    showAlertSuccess("View Deleted Successfully");
    if(UserViewInlineEditId&&String(UserViewInlineEditId)===String(userFilterId)) UserViewInlineEditId=null;
    applyViewActionToPage({clearFilters:!!(wasApplied||wasDefault)});
  }, function(){
    CloseDeleteFilterModal();
    showAlertError("Unable to delete view.");
  });
}
function DeleteUserView(userFilterId, filterName){
  if(!getSessionEmployeeId()||!userFilterId) return;
  OpenDeleteFilterModal(userFilterId, filterName);
}
function ApplySavedUserView(row){
  if(!row) return;
  AppliedUserFilterId=String(getApiField(row,"UserFilterID")||"");
  applyUserFilterChips(getApiField(row,"FilterJson"));
  showAlertSuccess("View Applied Successfully");
}
function StartInlineUserViewEdit(userFilterId){
  closeInlineMselPanels();
  UserViewInlineEditId=String(userFilterId);
  RenderMyViewsList(UserViewsCache);
}
function CancelInlineUserViewEdit(){
  closeInlineMselPanels();
  UserViewInlineEditId=null;
  RenderMyViewsList(UserViewsCache);
}
function SaveInlineUserViewEdit(userFilterId){
  const card=document.querySelector('.exec-view-row[data-view-id="'+userFilterId+'"]');
  const nameEl=card&&card.querySelector(".exec-inline-name");
  const defEl=card&&card.querySelector(".exec-inline-default");
  const name=(nameEl&&nameEl.value?nameEl.value:"").trim();
  const sid=getSessionEmployeeId();
  if(!sid){ showAlertError("Session expired. Please login again."); return; }
  if(!name){ showAlertError("Filter View Name is mandatory."); if(nameEl) nameEl.focus(); return; }
  const selectedMap=readInlineFilterEditor(card);
  const body={
    DashboardID:getDashboardId(),
    SessionEmployeeID:String(sid),
    UserFilterID:Number(userFilterId),
    FilterName:name,
    FilterJson:buildUserFilterJsonFromMap(selectedMap),
    IsDefaultFilter:!!(defEl&&defEl.checked)
  };
  callUserFilterApi("SaveUserFilter", body, function(json){
    const rows=getApiRows(json,"AnalyticsDBUserFilterModel");
    if(!rows||!rows.length){ showAlertError("Unable to update view."); return; }
    UserViewInlineEditId=null;
    closeInlineMselPanels();
    showAlertSuccess("View Updated Successfully");
    applyViewActionToPage({filterJson:body.FilterJson, userFilterId:userFilterId});
  }, function(){ showAlertError("Unable to update view. Please try again."); });
}
function RenderMyViewsList(list){
  const host=document.getElementById("execSavedViewsList");
  if(!host) return;
  list=list||[];
  if(!list.length){
    host.innerHTML='<div class="exec-view-empty">No saved views yet. Select filters and click Save View.</div>';
    return;
  }
  let html="";
  list.forEach(row=>{
    const id=String(getApiField(row,"UserFilterID"));
    const name=getApiField(row,"FilterName")||"Untitled";
    const d=getApiField(row,"IsDefaultFilter");
    const isDef=d===true||d===1||String(d).toLowerCase()==="true";
    const editing=UserViewInlineEditId&&String(UserViewInlineEditId)===id;
    const selectedMap=parseUserFilterChips(getApiField(row,"FilterJson"));
    if(editing){
      html+='<div class="exec-view-row is-editing'+(isDef?" is-default":"")+'" data-view-id="'+esc(id)+'">'+
        '<label class="exec-oc-label" for="uvInlineName_'+esc(id)+'">Filter View Name</label>'+
        '<input type="text" class="form-control exec-oc-input exec-inline-name" id="uvInlineName_'+esc(id)+'" maxlength="80" value="'+esc(name)+'" autocomplete="off">'+
        '<div class="exec-applied exec-view-applied">'+buildInlineFilterEditorHtml(selectedMap)+'</div>'+
        '<label class="exec-oc-check"><input type="checkbox" class="exec-inline-default"'+(isDef?" checked":"")+'>'+
        '<span>Set as Default</span></label>'+
        '<div class="exec-oc-actions">'+
        '<button type="button" class="ghostbtn exec-oc-primary" data-uv-inline-save="'+esc(id)+'">Save</button>'+
        '<button type="button" class="ghostbtn" data-uv-inline-cancel>Cancel</button>'+
        '</div></div>';
      return;
    }
    html+='<div class="exec-view-row'+(isDef?" is-default":"")+'" data-view-id="'+esc(id)+'">'+
      '<div class="exec-view-head">'+
      '<button type="button" class="exec-view-name" data-uv-apply="'+esc(id)+'" title="Apply this view">'+esc(name)+'</button>'+
      '<label class="exec-view-default"><input type="checkbox" data-uv-default="'+esc(id)+'"'+(isDef?" checked":"")+'>'+
      '<span>Set as Default</span></label>'+
      '<button type="button" class="exec-view-ico" data-uv-edit="'+esc(id)+'" title="Edit"><i class="fas fa-pen"></i></button>'+
      '<button type="button" class="exec-view-ico danger" data-uv-delete="'+esc(id)+'" title="Delete"><i class="far fa-trash-alt"></i></button>'+
      '</div><div class="exec-applied exec-view-applied">'+buildAppliedMultiFiltersHtml(selectedMap)+'</div></div>';
  });
  host.innerHTML=html;
  host.querySelectorAll("[data-uv-apply]").forEach(btn=>{
    btn.onclick=function(){
      const view=UserViewsCache.find(v=>String(getApiField(v,"UserFilterID"))===String(btn.getAttribute("data-uv-apply")));
      ApplySavedUserView(view);
    };
  });
  host.querySelectorAll("[data-uv-default]").forEach(cb=>{
    cb.onchange=function(){ SetUserViewDefault(cb.getAttribute("data-uv-default"), cb.checked); };
  });
  host.querySelectorAll("[data-uv-edit]").forEach(btn=>{
    btn.onclick=function(){ StartInlineUserViewEdit(btn.getAttribute("data-uv-edit")); };
  });
  host.querySelectorAll("[data-uv-delete]").forEach(btn=>{
    btn.onclick=function(){
      const view=UserViewsCache.find(v=>String(getApiField(v,"UserFilterID"))===String(btn.getAttribute("data-uv-delete")));
      if(UserViewInlineEditId&&String(UserViewInlineEditId)===String(btn.getAttribute("data-uv-delete")))
        UserViewInlineEditId=null;
      DeleteUserView(btn.getAttribute("data-uv-delete"), view?getApiField(view,"FilterName"):"");
    };
  });
  host.querySelectorAll("[data-uv-inline-save]").forEach(btn=>{
    btn.onclick=function(){ SaveInlineUserViewEdit(btn.getAttribute("data-uv-inline-save")); };
  });
  host.querySelectorAll("[data-uv-inline-cancel]").forEach(btn=>{
    btn.onclick=CancelInlineUserViewEdit;
  });
  bindInlineMultiSelectEditors(host.querySelector(".exec-view-row.is-editing"));
  const inlineName=host.querySelector(".exec-inline-name");
  if(inlineName){
    inlineName.focus();
    inlineName.addEventListener("keydown", function(e){
      if(e.key==="Enter"){ e.preventDefault(); SaveInlineUserViewEdit(UserViewInlineEditId); }
    });
  }
  if(typeof window.tsInitBlackTooltips==="function") window.tsInitBlackTooltips(host);
  else if(typeof initBlackTooltips==="function") initBlackTooltips(host);
}
function OpenMyViews(){
  GetTopFilterOption(function(){
    LoadUserViews(function(list){
      RenderMyViewsList(list);
      execOpenOffcanvas("execSavedViewsOffcanvas");
    });
  });
}
function InitApiUserSavedViews(){
  const ocSub=document.querySelector("#execSavedViewsOffcanvas .exec-oc-sub");
  if(ocSub){
    if(isTimesheetPage()) ocSub.textContent="Resource Timesheets";
    else if(typeof PAGE_NAMES!=="undefined") ocSub.textContent=PAGE_NAMES[CURRENT_PAGE]||"Dashboard";
  }
  const saveViewBtn=document.getElementById("execSaveViewBtn");
  const myViewsBtn=document.getElementById("execMyViewsBtn");
  const saveBtn=document.getElementById("execViewSaveBtn");
  const modalClose=document.getElementById("execSaveModalClose");
  const modalCancel=document.getElementById("execSaveModalCancel");
  const modal=document.getElementById("execSaveModal");
  const nameEl=document.getElementById("execViewName");
  const delClose=document.getElementById("execDeleteFilterClose");
  const delNo=document.getElementById("execDeleteFilterNo");
  const delYes=document.getElementById("execDeleteFilterYes");
  const delModal=document.getElementById("execDeleteFilterModal");

  if(saveViewBtn) saveViewBtn.onclick=function(){ OpenSaveViewModal(null); };
  if(myViewsBtn) myViewsBtn.onclick=OpenMyViews;
  if(saveBtn) saveBtn.onclick=SaveUserView;
  if(modalClose) modalClose.onclick=CloseSaveViewModal;
  if(modalCancel) modalCancel.onclick=CloseSaveViewModal;
  if(modal) modal.addEventListener("click", function(e){ if(e.target===modal) CloseSaveViewModal(); });
  if(nameEl) nameEl.addEventListener("keydown", function(e){
    if(e.key==="Enter"){ e.preventDefault(); SaveUserView(); }
  });
  document.querySelectorAll("[data-exec-oc-close]").forEach(function(el){
    el.onclick=function(e){
      e.preventDefault(); e.stopPropagation();
      execCloseOffcanvas(el.getAttribute("data-exec-oc-close"));
    };
  });
  const bd=document.getElementById("execViewBackdrop");
  if(bd && !bd._ocBound){
    bd._ocBound=true;
    bd.onclick=function(){ execCloseOffcanvas(); };
  }
  document.addEventListener("keydown", function(e){
    if(e.key!=="Escape") return;
    const del=document.getElementById("execDeleteFilterModal");
    if(del && !del.hidden){ CloseDeleteFilterModal(); return; }
    const wrap=document.getElementById("execSaveModal");
    if(wrap && !wrap.hidden){ CloseSaveViewModal(); return; }
    if(UserViewInlineEditId){ CancelInlineUserViewEdit(); return; }
    const oc=document.getElementById("execSavedViewsOffcanvas");
    if(oc && oc.classList.contains("show")) execCloseOffcanvas("execSavedViewsOffcanvas");
  });
  if(delClose) delClose.onclick=CloseDeleteFilterModal;
  if(delNo) delNo.onclick=CloseDeleteFilterModal;
  if(delYes) delYes.onclick=ConfirmDeleteUserView;
  if(delModal) delModal.addEventListener("click", function(e){ if(e.target===delModal) CloseDeleteFilterModal(); });

  /* window.* exports are set once below (after execInitSavedViews) so CXO can call them before Init runs. */
}


function execInitSavedViews(){
  if(canUseUserFilterApis()){
    InitApiUserSavedViews();
    return;
  }
  const ocSub=document.querySelector("#execSavedViewsOffcanvas .exec-oc-sub");
  if(ocSub && typeof PAGE_NAMES!=="undefined") ocSub.textContent=PAGE_NAMES[CURRENT_PAGE]||"Dashboard";
  const saveViewBtn=$("#execSaveViewBtn");
  if(saveViewBtn) saveViewBtn.onclick=execOpenSaveModal;
  const myViewsBtn=$("#execMyViewsBtn");
  if(myViewsBtn) myViewsBtn.onclick=execOpenMyViews;
  const defBtn=$("#execDefaultViewBtn");
  if(defBtn) defBtn.onclick=()=>execApplyDefaultView();
  const saveBtn=$("#execViewSaveBtn");
  if(saveBtn) saveBtn.onclick=execSaveCurrentView;
  const modalClose=$("#execSaveModalClose");
  if(modalClose) modalClose.onclick=execCloseSaveModal;
  const modalCancel=$("#execSaveModalCancel");
  if(modalCancel) modalCancel.onclick=execCloseSaveModal;
  const modal=$("#execSaveModal");
  if(modal) modal.addEventListener("click", e=>{ if(e.target===modal) execCloseSaveModal(); });
  $$("[data-exec-oc-close]").forEach(el=>{
    el.onclick=()=>execCloseOffcanvas(el.getAttribute("data-exec-oc-close"));
  });
  const bd=$("#execViewBackdrop");
  if(bd) bd.onclick=()=>execCloseOffcanvas();
  document.addEventListener("keydown", e=>{
    if(e.key!=="Escape") return;
    const wrap=$("#execSaveModal");
    if(wrap && !wrap.hidden){ execCloseSaveModal(); return; }
    if(execInlineEditId){ execCancelInlineEdit(); return; }
    execCloseOffcanvas();
  });
  const nameEl=$("#execViewName");
  if(nameEl) nameEl.addEventListener("keydown", e=>{
    if(e.key==="Enter"){ e.preventDefault(); execSaveCurrentView(); }
  });
  execSyncDefaultBtn();
  const def=execGetDefaultView();
  if(def) execApplySnapshot(def.snapshot, {skipRender:true});
}

/* Generic Save / My / Edit / Delete / Set Default — CXO (SKIP_APP_JS_BOOT) + Timesheet. */
window.execInitSavedViews=execInitSavedViews;
window.InitApiUserSavedViews=InitApiUserSavedViews;
window.execOpenSaveModal=function(){ OpenSaveViewModal(null); };
window.execSaveCurrentView=SaveUserView;
window.execOpenMyViews=OpenMyViews;
window.execCloseSaveModal=CloseSaveViewModal;
window.execRenderAppliedFilters=function(){ renderSaveViewAppliedFilters(TopFilter.selected); };
window.LoadDefaultUserView=LoadDefaultUserView;
window.LoadUserViews=LoadUserViews;
window.OpenSaveViewModal=OpenSaveViewModal;
window.CloseSaveViewModal=CloseSaveViewModal;
window.SaveUserView=SaveUserView;
window.OpenMyViews=OpenMyViews;
window.DeleteUserView=DeleteUserView;
window.ConfirmDeleteUserView=ConfirmDeleteUserView;
window.SetUserViewDefault=SetUserViewDefault;
window.StartInlineUserViewEdit=StartInlineUserViewEdit;
window.CancelInlineUserViewEdit=CancelInlineUserViewEdit;
window.SaveInlineUserViewEdit=SaveInlineUserViewEdit;
window.RenderMyViewsList=RenderMyViewsList;
window.applyViewActionToPage=applyViewActionToPage;
window.buildUserFilterJson=buildUserFilterJson;
try{
  Object.defineProperty(window,"AppliedUserFilterId",{
    configurable:true,
    enumerable:true,
    get:function(){ return AppliedUserFilterId; },
    set:function(v){ AppliedUserFilterId=v; }
  });
}catch(e){ window.AppliedUserFilterId=AppliedUserFilterId; }

/* boot — CXO aspx sets window.SKIP_APP_JS_BOOT=true so cascade helpers load without owning the page shell. */
function hideAnalyticsPreloader(){
  const pre=document.getElementById("AnalyticsPreloader");
  const wrap=document.getElementById("AnalyticsWrapper");
  if(pre) pre.style.display="none";
  if(wrap) wrap.style.display="";
  // Charts often need a resize once the wrapper becomes visible
  Object.keys(state.charts||{}).forEach(id=>{
    try{ if(state.charts[id]) state.charts[id].resize(); }catch(err){}
  });
}
if(!window.SKIP_APP_JS_BOOT){
restoreState();
(function preventAspNetPostback(){
  const form=document.getElementById("form1")||document.querySelector("form[runat], form");
  if(!form) return;
  form.addEventListener("submit", function(e){
    e.preventDefault();
    e.stopPropagation();
    return false;
  }, true);
})();
syncRolePill();
execInitSavedViews();
renderChips();
setTrail([]);
bindDatePickerButton();

function bootDashboardShell(){
  if(typeof window.tsPageBoot==="function"){
    window.tsPageBoot();
  }else{
    if(typeof bindBlackTooltipDismiss==="function") bindBlackTooltipDismiss();
    syncDateUI();
    renderPage();
    requestAnimationFrame(()=>{
      if(typeof initBlackTooltips==="function") initBlackTooltips(document);
      requestAnimationFrame(hideAnalyticsPreloader);
    });
  }
  setTimeout(hideAnalyticsPreloader, 8000);
}

if(canUseFilterApis()){
  /* Timesheet page-load: 1 FlagWise chips → 2+3 date options/range → 4 KPI via renderPage */
  GetTopFilterOption(function(){
    renderChips();
    InitSharedDateFilter(function(){
      bootDashboardShell();
    });
  });
}else{
  refreshRelativeDateState();
  syncDateFilterFromState();
  bootDashboardShell();
}
/* auto refresh pulse */
setInterval(()=>{const el=$(".sidebar-foot"); if(el)el.title="Auto-refresh: 60s";},60000);
/* Keep charts sized like the 2-column screenshot when the iframe / window resizes */
let _cxoResizeTimer=null;
window.addEventListener("resize",()=>{
  clearTimeout(_cxoResizeTimer);
  _cxoResizeTimer=setTimeout(()=>{
    Object.keys(state.charts||{}).forEach(id=>{
      try{ if(state.charts[id]) state.charts[id].resize(); }catch(err){}
    });
  },120);
});
}
