using System.Runtime.InteropServices;

namespace FirebirdSql.Bin.Version3 {
    public static class ClientAssembly {

        static ClientAssembly() {
            {

                var ret = default(string?);
                var tret = new[] {
                    (OperatingSystem.IsWindows() && RuntimeInformation.ProcessArchitecture == Architecture.X64, FirebirdSql.Bin.Constants.Version3_Win_x64),
                    (OperatingSystem.IsWindows() && RuntimeInformation.ProcessArchitecture == Architecture.X86, FirebirdSql.Bin.Constants.Version3_Win_x86),
                    (OperatingSystem.IsLinux() && RuntimeInformation.ProcessArchitecture == Architecture.X64, FirebirdSql.Bin.Constants.Version3_Linux_x64),
                    (OperatingSystem.IsLinux() && RuntimeInformation.ProcessArchitecture == Architecture.X86, FirebirdSql.Bin.Constants.Version3_Linux_x86),
                }.Where(x => x.Item1 && System.IO.File.Exists(x.Item2)).Select(x => x.Item2).FirstOrDefault();

                if (!string.IsNullOrWhiteSpace(tret)) {
                    ret = System.IO.Path.Combine(System.AppDomain.CurrentDomain.BaseDirectory, tret);
                }

                FullPath = ret;
            }
        }

        public static string? FullPath { get; }
    }
}
