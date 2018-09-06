using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using Webserver.Models;
using Webserver.Models.ModelView;

namespace Webserver.Controllers
{
    [RoutePrefix("api/ThongBao")]
    public class ThongBaoController : ApiController
    {
        AppEntities db = new AppEntities();
        [AllowAnonymous]
        [Route("CreateThongBao")]
        [HttpPost]
        public async Task<IHttpActionResult> CreateThongBao(string TieuDe,string NoiDung,string NBD,string NKT,string US)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            ThongBao tb = new ThongBao();
            tb.MaTB ="TB_"+ DateTime.Now.ToShortDateString()+"_"+(db.ThongBaos.ToList().Count()+1);
            var dt = db.ThongBaos.FirstOrDefault(x => x.MaTB == tb.MaTB);
            if (dt!=null)
            {
                tb.MaTB = "TB_" + DateTime.Now.ToShortDateString() + "_" + (db.ThongBaos.ToList().Count() + 2);
            }
            tb.TieuDe = TieuDe;
            tb.NoiDung = NoiDung;
            DateTime date = DateTime.Parse(NBD);
            
            tb.NgayBatDau = date;

            DateTime date2 = DateTime.Parse(NKT);

            tb.NgayKetThuc = date2;
            tb.MaUser = US;
            tb.NgayTao = DateTime.Now;
            db.ThongBaos.Add(tb);


            await db.SaveChangesAsync();
            return Ok(new {Code=200});
        }
        [AllowAnonymous]
        [Route("GetThongBao")]
        [HttpGet]
        public async Task<IHttpActionResult> GetThongBao()
        {
            var data = await db.ThongBaos.ToListAsync();
            var lst = data.Where(x => x.NgayKetThuc >= DateTime.Now).ToList();//Kiểm tra ngày kết thúc có bé hơn
            if (lst.Count > 0)
            {
                List<ThongBaoView> lstRe = new List<ThongBaoView>();
                foreach (ThongBao item in lst.OrderByDescending(x=>x.NgayTao))
                {

                    lstRe.Add(new ThongBaoView() {
                        MaTB = item.MaTB,
                        TieuDe = item.TieuDe,
                        NgayTao = String.Format("{0:dd/MM/yyyy}", item.NgayBatDau)
                    });
                }
                return Ok(new { Code = 200,data = lstRe });
            }

            return Ok(new { Code = 201 });
        }

        [AllowAnonymous]
        [Route("GetThongBaoByID")]
        [HttpGet]
        public async Task<IHttpActionResult> GetThongBaoByID(string MaTB)
        {
            var data = await db.ThongBaos.ToListAsync();
            var item = data.FirstOrDefault(x => x.MaTB == MaTB && x.NgayKetThuc >= DateTime.Now);
            if (item != null)
            {
                ThongBaoView lstRe = new ThongBaoView();
                lstRe.MaTB = item.MaTB;
                lstRe.TieuDe = item.TieuDe;
                lstRe.NoiDung = item.NoiDung;
                lstRe.NgayBatDau = String.Format("{0:dd/MM/yyyy}", item.NgayBatDau);
                lstRe.NgayKetThuc = String.Format("{0:dd/MM/yyyy}", item.NgayKetThuc);
                lstRe.MaUser = item.MaUser;
                lstRe.NgayTao = String.Format("{0:dd/MM/yyyy}", item.NgayBatDau);
                return Ok(new { Code = 200, data = lstRe });
            }

            return Ok(new { Code = 201 });
        }
    }
}
    
    
