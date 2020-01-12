using COESystem.DAL;
using COESystem.Data.Entities;
using COESystem.Data.POCOs;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace COESystem.BLL.CrewLeaderControllers
{
    [DataObject]
    public class UnitControllers
    {
        //Returns the list of Units of a given Yard (YardID)
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<YardUnits> GetUnits(int yardId)
        {
            using (var context = new COESystemContext())
            {
                var CurrentUnit = from x in context.Units
                                  where x.YardID == yardId
                                  select new YardUnits
                                  {
                                      ID = x.UnitID,
                                      Number = x.UnitNumber,
                                      Description = x.UnitDescription,
                                  };
                return CurrentUnit.ToList();
            }
        }
    }
}
