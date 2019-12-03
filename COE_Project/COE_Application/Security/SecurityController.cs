using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

#region Additional Namespace
using System.ComponentModel;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using COE_Application.Models;
using System.Configuration;
#endregion

namespace COE_Application.Security
{
    [DataObject]
    public class SecurityController
    {
        #region Constructors & Dependencies
        private readonly ApplicationUserManager UserManager;
        private readonly RoleManager<IdentityRole> RoleManager;
        public SecurityController()
        {
            UserManager = HttpContext.Current.Request.GetOwinContext().GetUserManager<ApplicationUserManager>();
            RoleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(new ApplicationDbContext()));
        }
        private void CheckResult(IdentityResult result, string item, string action)
        {
            if (!result.Succeeded)
                throw new Exception($"Failed to " + action + $" " + item +
                    $":<ul> {string.Join(string.Empty, result.Errors.Select(x => $"<li>{x}</li>"))}</ul>");
        }
        #endregion

        #region ApplicationUser CRUD
        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<ApplicationUser> ListUsers()
        {
            return UserManager.Users.Where(x => x.EmployeeId.HasValue).OrderBy(x => x.UserName).ToList();
        }

        [DataObjectMethod(DataObjectMethodType.Insert)]
        public void AddUser(ApplicationUser user)
        {
            if (user.EmployeeId == 0)
            {
                throw new Exception("Select an Employee");
            }
            if (user.EmployeeId == 0)
            {
                user.EmployeeId = null;
            }

            IdentityResult result = UserManager.Create(user, ConfigurationManager.AppSettings["newUserPassword"]);
        }
        #endregion
    }
}