using Microsoft.EntityFrameworkCore;
using ShapeAssessment.Models;

namespace ShapeAssessment
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            Common.Constants.CONNECTION_STRING = builder.Configuration.GetConnectionString(Common.Constants.CONNECTION_NAME);
            builder.Services.AddDbContext<ShapeContext>(options => options.UseSqlServer(Common.Constants.CONNECTION_STRING));
            
            // Add services to the container.
            builder.Services.AddControllersWithViews();
            //Adding Session Configurations to remember user login
            builder.Services.AddDistributedMemoryCache();
            builder.Services.AddSession(options => {
                options.Cookie.Name = ".Shape.Session";
                options.IdleTimeout = TimeSpan.FromMinutes(30);
                options.Cookie.HttpOnly = true;
                options.Cookie.IsEssential = true;
            });

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (!app.Environment.IsDevelopment())
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            //app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthorization();

            app.UseSession();

            app.MapControllerRoute(
                name: "default",
                pattern: "{controller=Users}/{action=Index}/{id?}");

            app.Run();
        }
    }
}