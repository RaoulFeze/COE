using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace COESystem.Data.POCOs
{
    public class Status
    {
		public int Pin { get; set; }

		public string Community { get; set; }

		public string Neighbourhood { get; set; }

		public string Address { get; set; }

		public int Area { get; set; }

		public string Notes { get; set; }

		public Cycle Cycle1 { get; set; }

		public Cycle Cycle2 { get; set; }

		public Cycle Cycle3 { get; set; }

		public Cycle Cycle4 { get; set; }

		public Cycle Cycle5 { get; set; }

		public Cycle Pruning { get; set; }

		public Cycle Mulching { get; set; }
	}
}
