using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namespaces
using System.ComponentModel;
using COESystem.Data.Entities;
using COESystem.DAL;
#endregion
namespace COESystem.BLL.CrewLeaderControllers
{
    [DataObject]
    public class EmployeeControllers
    {

        //Returns the list of field employees of a given Yard (YardID)
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<Employee> GetEmployees(int yardId)
        {
            using (var context = new COESystemContext())
            {
                var employeeList = from x in context.Employees
                                   where x.YardID == yardId && x.TeamLeader == false && x.CrewLeader == false
                                   select x;
                return employeeList.ToList();
            }
        }
    }
}
