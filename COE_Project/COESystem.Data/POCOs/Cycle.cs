using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace COESystem.Data.POCOs
{
    public class Cycle
    {
		private DateTime? _Date;

		public DateTime? Date
		{
			get => DbFunctions.TruncateTime(_Date);

			set => _Date = DbFunctions.TruncateTime(value);
		}
	}
}
