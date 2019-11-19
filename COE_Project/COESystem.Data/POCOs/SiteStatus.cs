using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace COESystem.Data.POCOs
{
    public class SiteStatus
    {
        public DateTime? SBM { get; set; }
        public DateTime? Prune { get; set; }
        public DateTime? Mulch { get; set; }
    }
}
