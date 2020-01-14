using System;
using System.Text;
using System.Threading.Tasks;

#region Additional namespaces
using COESystem.DAL;
using COESystem.Data.Entities;
using COECommon.UserControls;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Entity;
using System.Linq;
#endregion

namespace COESystem.BLL.CrewLeaderControllers
{
    [DataObject]
    public class CrewControllers
    {
        //This method returns the Crew of a crew based on the Date and UnitID
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public Crew GetCrew(int unitID, DateTime date)
        {
            using(var context = new COESystemContext())
            {
                Crew crew = (from x in context.Crews
                           where x.UnitID == unitID && DbFunctions.TruncateTime(date) == DbFunctions.TruncateTime(x.Date)
                            select x).FirstOrDefault();
                return crew;
            }
        } 

        //This method create a new crew
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public void CreateCrew(int unitId)
        {
            using(var context = new COESystemContext())
            {
                Crew crew = (from x in context.Crews
                            where x.UnitID == unitId && DbFunctions.TruncateTime(DateTime.Now) == DbFunctions.TruncateTime(x.Date)
                            select x).FirstOrDefault();

                List<string> reasons = new List<string>();

                if(crew == null)
                {
                    //Create the new Crew
                    crew = new Crew();
                    crew.UnitID = unitId;
                    crew.Date = (DateTime)DbFunctions.TruncateTime(DateTime.Now);
                    context.Crews.Add(crew);
                }
                else
                {
                    UnitControllers unitManager = new UnitControllers();
                    Unit unit = unitManager.GetUnit(unitId);
                    reasons.Add("A crew is already assigned with Unit " + unit.UnitNumber);
                }
                if (reasons.Count() > 0)
                {
                    throw new BusinessRuleException("Creatting new Crew ", reasons);
                }
            }
        }
    }
}
