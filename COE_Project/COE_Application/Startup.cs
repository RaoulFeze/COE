using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(COE_Application.Startup))]
namespace COE_Application
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
