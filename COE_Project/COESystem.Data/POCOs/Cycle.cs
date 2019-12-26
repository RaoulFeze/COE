using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace COESystem.Data.POCOs
{
    public class Cycle
    {
		private DateTime _Date;

		public DateTime Date
		{
			get => _Date;

			set => _Date = value;
		}

		public DateTime GetDate()
		{
			return _Date;
		}
	}
}
