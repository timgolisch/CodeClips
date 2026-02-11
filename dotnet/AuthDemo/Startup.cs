using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(AuthDemo.Startup))]
namespace AuthDemo
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
