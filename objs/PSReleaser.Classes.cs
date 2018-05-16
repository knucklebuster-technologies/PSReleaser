using System.Collections;
using System.Collections.Generic;

namespace PSReleaser
{
    public class CfgFile
    {

    }

    public class LockFile
    {

    }

    public class Project
    {
        public string        Timestamp;
        public string        RunName;
        public string        Status;
        public bool          Running;
        public CfgFile       Cfg;
        public PSReleaser.Lock          Lock;
        public List<object>  CompletedTasks;
        public List<object>  LogEntries;
        public hashtable     Manifest;
    }
}