using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using Webserver.Models;

namespace Webserver.Controllers
{
    [RoutePrefix("api/TaiKhoan")]
    public class TaiKhoanController : ApiController
    {
        AppEntities db = new AppEntities();
        [AllowAnonymous]
        [Route("login")]
        [HttpPost]
        public async Task<IHttpActionResult> Login(string userName, string password)
        {
            var data = await db.TaiKhoans.ToListAsync();
            TaiKhoan tk = data.FirstOrDefault(x => x.TenTaiKhoan == userName && x.MatKhau == password);
            if (tk != null)
            {
                return Ok(new { data = tk, Code = 200 });
            }
            else
            {
                return Ok(new { Code = 201 });
            }
        }


        [HttpGet]
        [AllowAnonymous]
        [Route("getAllEmployee")]
        public async Task<IHttpActionResult> getAllEmployee()
        {
            var data = await db.TaiKhoans.ToListAsync();
            data = data.Where(x => x.MaQuyen != "Admin").ToList();
            return Ok(new{ data = data, Code = 200});
        }

        
    }
}
