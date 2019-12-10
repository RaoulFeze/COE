
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity;
using System.Linq;
using System.Web;

#region Additinal Namespaces
using COE_Application.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
#endregion

namespace COE_Application.Security
{
    public class SecurityDbContextInitializer: CreateDatabaseIfNotExists<ApplicationDbContext>
    {
        protected override void Seed(ApplicationDbContext context)
        {
            #region Seed the Roles
            var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));
            var startupRoles = ConfigurationManager.AppSettings["startupRoles"].Split(';');
            foreach(var role in startupRoles)
            {
                roleManager.Create(new IdentityRole { Name = role });
            }
            #endregion

            #region Seed the Users
            //Administrators
            string adminUserName = ConfigurationManager.AppSettings["adminUserName"];
            string adminRole = ConfigurationManager.AppSettings["adminRole"];
            string adminEmail = ConfigurationManager.AppSettings["adminEmail"];
            string adminPassword = ConfigurationManager.AppSettings["adminPassword"];

            var userManager = new ApplicationUserManager(new UserStore<ApplicationUser>(context));
            var result = userManager.Create(new ApplicationUser
            {
                UserName = adminUserName,
                Email = adminEmail
            }, adminPassword);
           
            if (result.Succeeded)
            {
                userManager.AddToRole(userManager.FindByName(adminUserName).Id, adminRole);
            }

            //CrewLeaders
            string crewLeaderUserName = ConfigurationManager.AppSettings["crewLeaderUserName"];
            string crewLeaderRole = ConfigurationManager.AppSettings["crewLeaderRole"];
            string crewLeaderEmail = ConfigurationManager.AppSettings["crewLeaderEmail"];
            string crewLeaderPassword = ConfigurationManager.AppSettings["crewLeaderPassword"];

            result = userManager.Create(new ApplicationUser
            {
                UserName = crewLeaderUserName,
                Email = crewLeaderEmail,
                CrewLeaderId = 145
            }, crewLeaderPassword); ;

            if (result.Succeeded)
            {
                userManager.AddToRole(userManager.FindByName(crewLeaderUserName).Id, crewLeaderRole);
            }

            //Procurement

            //FieldEmployee

            //Gardener

            //TeamLeader
            #endregion
        }
    }
}