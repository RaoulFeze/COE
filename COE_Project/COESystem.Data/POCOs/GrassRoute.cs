using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace COESystem.Data.POCOs
{
    public class GrassStatus
    {
		public int Pin { get; set; }

		public string Community { get; set; }

		public string Neighbourhood { get; set; }

		public string Address { get; set; }

		public int Area { get; set; }

		public string Notes { get; set; }

		public int? Count { get; set; }

		public DateTime? Trimming { get; set; }
	}
}
