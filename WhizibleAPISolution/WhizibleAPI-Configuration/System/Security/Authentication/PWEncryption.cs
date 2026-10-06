namespace System.Security.Authentication
{
    internal class PWEncryption
    {
        private string loginName;
        private string newPassword;

        public PWEncryption(string loginName, string newPassword)
        {
            this.loginName = loginName;
            this.newPassword = newPassword;
        }

        internal string Encrypt()
        {
            throw new NotImplementedException();
        }
    }
}