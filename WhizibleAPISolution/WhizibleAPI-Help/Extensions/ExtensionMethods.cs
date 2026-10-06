using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Extensions
{
    public static class ExtensionMethods
    {
        public static List<T> ToList<T>(this DataTable dt)
        {
            var data = new List<T>();
            foreach (DataRow row in dt.Rows)
            {
                var item = GetItem<T>(row);
                data.Add(item);
            }

            return data;
        }
        private static T GetItem<T>(DataRow dr)
        {
            var temp = typeof(T);
            var obj = Activator.CreateInstance<T>();

            foreach (DataColumn column in dr.Table.Columns)
                foreach (var pro in temp.GetProperties())
                    if (pro.Name == column.ColumnName && dr[column.ColumnName] != DBNull.Value)
                        pro.SetValue(obj, dr[column.ColumnName], null);
                    else
                        continue;
            return obj;
        }

        public static List<T> ToListCast<T>(this DataTable dt)
        {
            var data = new List<T>();
            foreach (DataRow row in dt.Rows)
            {
                var item = GetItemCast<T>(row);
                data.Add(item);
            }

            return data;
        }
        private static T GetItemCast<T>(DataRow dr)
        {
            var temp = typeof(T);
            var obj = Activator.CreateInstance<T>();

            foreach (DataColumn column in dr.Table.Columns)
                foreach (var pro in temp.GetProperties())
                    if (pro.Name == column.ColumnName && dr[column.ColumnName] != DBNull.Value)
                        if (pro.PropertyType == typeof(Single))
                        {
                            pro.SetValue(obj, Convert.ToInt32(dr[column.ColumnName]), null);
                        }
                        else if (pro.PropertyType == typeof(double))
                        {
                            pro.SetValue(obj, Convert.ToDouble(dr[column.ColumnName]), null);
                        }
                        else if (pro.PropertyType == typeof(decimal))
                        {
                            pro.SetValue(obj, Convert.ToDecimal(dr[column.ColumnName]), null);
                        }
                        else if (pro.PropertyType == typeof(DateTime))
                        {
                            pro.SetValue(obj, Convert.ToDateTime(dr[column.ColumnName]), null);
                        }
                        else
                        {
                            pro.SetValue(obj, dr[column.ColumnName], null);
                        }

                    else
                        continue;
            return obj;
        }
    }
}
