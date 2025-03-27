


using System;

    static internal partial class InternalAssemblyInfo {

		public const string AssemblyBuildDateString = "03/19/2025 15:51:05 -05:00" ;
		public static DateTimeOffset AssemblyBuildDate {get; }

        public const string AssemblyVersionString = "25.03.19.1551";
        public static Version AssemblyVersion {get; } 


        static InternalAssemblyInfo(){
            AssemblyBuildDate = DateTimeOffset.Parse(AssemblyBuildDateString, System.Globalization.DateTimeFormatInfo.InvariantInfo);
            AssemblyVersion = new Version(AssemblyVersionString);
        }

	}
