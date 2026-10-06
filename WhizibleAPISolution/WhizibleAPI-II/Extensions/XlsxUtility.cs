using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Extensions
{
    public static class XlsxUtility
    {
        public static DataTable ConvertCSVtoDataTable(string strFilePath)
        {
            DataTable dt = new DataTable();
            using (StreamReader sr = new StreamReader(strFilePath))
            {
                string[] headers = sr.ReadLine().Split(',');
                foreach (string header in headers)
                {
                    dt.Columns.Add(header);
                }

                while (!sr.EndOfStream)
                {
                    string[] rows = sr.ReadLine().Split(',');
                    if (rows.Length > 1)
                    {
                        DataRow dr = dt.NewRow();
                        for (int i = 0; i < headers.Length - 1; i++)
                        {
                            if (rows != null && rows[i] != null)
                            {
                                dr[i] = rows[i].Trim();
                            }

                        }
                        dt.Rows.Add(dr);
                    }
                }

            }
            return dt;
        }

        public static DataTable ConvertXSLXtoDataTable(string strFilePath, string connString)
        {
            OleDbConnection oledbConn = new OleDbConnection(connString);
            DataTable dt = new DataTable();
            try
            {

                oledbConn.Open();
                using (OleDbCommand cmd = new OleDbCommand("SELECT * FROM [Sheet1$]", oledbConn))
                {
                    OleDbDataAdapter oleda = new OleDbDataAdapter();
                    oleda.SelectCommand = cmd;
                    DataSet ds = new DataSet();
                    oleda.Fill(ds);
                    dt = ds.Tables[0];
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                oledbConn.Close();
            }
            return dt;

        }

        public static bool IsEmptyfield(string Value)
        {
            if (string.IsNullOrEmpty(Value))
            {
                return true;
            }
            return false;
        }
        public static bool IsNumeric(string Value)
        {
            return IsNumeric(Value);
        }

        public static bool IsDecimal(string value)
        {
            try
            {
                Decimal.Parse(value);
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Using posted file
        /// </summary>
        /// <param name="PostedDocumentFile"></param>
        /// <returns></returns>
        public static bool IsFileExtensionValid(HttpPostedFile PostedDocumentFile)
        {
            var ext = new FileInfo(PostedDocumentFile.FileName).Extension?.Replace('.', ' ')?.Trim();
            if (ConfigurationManager.AppSettings["filetypenotallowed"].Split(',').Contains(ext))
                return false;
            return true;
        }
        /// <summary>
        /// Checked with array
        /// </summary>
        /// <param name="PostedDocumentFile"></param>
        /// <returns></returns>
        public static bool IsValidFileFile(string Extension)
        {
            //check file extension
            string[] validFileTypes = { ".xls", ".xlsx", ".csv" };
            bool IsValid = validFileTypes.Contains(Extension) ? true : false;
            return IsValid;
        }

        //public static void CreateDocDirectory(string Path)
        //{
        //    bool exists = Directory.Exists(Path);
        //    if (!exists)
        //        Directory.CreateDirectory(Path);
        //}

        public static bool CompareValues(int value1, int value2)
        {
            if (value1 > value2)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public static bool CompareDecValues(Decimal value1, Decimal value2)
        {
            if (value1 > value2)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static void DeleteFileIfExist(string FilePath)
        {
            if (File.Exists(FilePath))
            { File.Delete(FilePath); }
        }

        internal static void CreateDocDirectory(string folderPath)
        {
            bool exists = Directory.Exists(folderPath);
            if (!exists)
                Directory.CreateDirectory(folderPath);
        }

        internal static bool IsEmptyfield(int statusID)
        {
            throw new NotImplementedException();
        }

        ///[RegularExpression(@"^\d{1,2}(\.\d{0,2})$", ErrorMessage = "Value contains more than 2 decimal places")]
    }
}