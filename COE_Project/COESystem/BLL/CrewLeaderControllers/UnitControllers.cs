using COESystem.DAL;

using System;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Addtional Namespaces
using COESystem.Data.Entities;
using COESystem.Data.POCOs;
using System.Collections.Generic;
using System.ComponentModel;
#endregion

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

        //Ruturns a Unit based on its UnitID
        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public Unit GetUnit(int unitId)
        {
            using(var context = new COESystemContext())
            {
                return context.Units.Find(unitId);
            }
        }
    }
}
