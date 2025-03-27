namespace Firebird.Test {
    internal class Program {
        static void Main(string[] args) {

            Console.WriteLine(System.Runtime.InteropServices.RuntimeInformation.RuntimeIdentifier);

            var Lib = FirebirdSql.Bin.Version3.ClientAssembly.FullPath;

            Lib = $@"C:\Program Files\Spectral Core\Full Convert\fbembed\fb-3.0\fbclient.dll";
            //Lib = $@"C:\Program Files\Spectral Core\Full Convert\fbembed\fb-4.0\fbclient.dll";
            //Lib = $@"C:\Users\Administrator\Downloads\Firebird-2.5.9.27139-0_x64_embed\fbembed.dll";

            Console.WriteLine(Lib);

            var DbPath = $@"B:\LEGACY_TimeSlips_TestDb3_Firebird.FDB";
            
            var C = new FirebirdSql.Data.FirebirdClient.FbConnectionStringBuilder();
            C.ClientLibrary = Lib;
            C.ServerType = FirebirdSql.Data.FirebirdClient.FbServerType.Embedded;
            C.Database = $@"{DbPath}";
            C.UserID = "SYSDBA";
            C.Password = "masterkey";



            var CS = C.ToString();

            CS = $@"User=SYSDBA;Password=masterkey;Database={DbPath};ServerType=1;Dialect=3;Charset=UTF8;ClientLibrary={Lib}";

            var Conn = new FirebirdSql.Data.FirebirdClient.FbConnection(CS);
            Conn.Open();




        }

        private const ushort FirebirdFlag = 0x8000;

        private void DispObsVersinoFromBinary(string path) {
            using (var fs = new FileStream(path, FileMode.Open, FileAccess.Read)) {
                int fileSize = (int)fs.Length;
                byte[] buf = new byte[1024];
                fs.Read(buf, 0, 1024);
                var obsHex = string.Join("", buf.Skip(0x12).Take(2).Select(x => x.ToString("X2")).Reverse());
                var minor = string.Join("", buf.Skip(0x40).Take(2).Select(x => x.ToString("X2")).Reverse());
                Console.WriteLine($"ODSVer:{Convert.ToInt32(obsHex, 16) & ~FirebirdFlag}");
                Console.WriteLine($"ODSMinorVer:{Convert.ToInt32(minor, 16)}");
            }
        }

    }
}
