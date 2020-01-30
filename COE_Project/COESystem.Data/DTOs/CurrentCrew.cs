using COESystem.Data.POCOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace COESystem.Data.DTOs
{
    public class CurrentCrew
    {
        public string Unit { get; set; }
        public int UnitID { get; set; }
        public List<Member> Crew { get; set; }
        public List<WorkSite> Sites { get; set; }
    }
}
