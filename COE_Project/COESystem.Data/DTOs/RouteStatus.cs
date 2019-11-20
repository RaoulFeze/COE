
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namesapces
using COESystem.Data.POCOs;
#endregion

namespace COESystem.Data.DTOs
{
    public class RouteStatus
    {
        public int Pin { get; set; }
        public string Community { get; set; }
        public string Description { get; set; }
        public string Address { get; set; }
        public int Area { get; set; }
        public string Notes { get; set; }
        public List<SiteStatus> JobDone { get; set; }
    }
}
