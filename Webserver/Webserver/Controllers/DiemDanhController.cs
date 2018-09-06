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
    
    [RoutePrefix("api/DiemDanh")]
    public class DiemDanhController : ApiController
    {
        AppEntities db = new AppEntities();
        [AllowAnonymous]
        [Route("CreateDiemDanh")]
        [HttpPost]
        public async Task<IHttpActionResult> CreateDiemDanh(string MaUser)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            DateTime date = new DateTime();
            date = DateTime.Now;
            string buoi = date.Hour < 12 ? "sa" : "ch";

            var dk = db.DuKienTTs.FirstOrDefault(x => x.Ngay == date.Day.ToString() && x.Thang == date.Month.ToString() && x.MaUser == MaUser);
            string ma = "DD_" + dk.MaDuKien + "_" + date.Day.ToString() + date.Month.ToString() + "_" + buoi.ToUpper();
            if (db.DiemDanhs.FirstOrDefault(x=>x.MaDD == ma) == null)
            {
                DiemDanh dd = new DiemDanh();
                dd.MaDD = ma;
                dd.MaDuKien = dk.MaDuKien;
                dd.Ngay = date;
                dd.Buoi = buoi;
                db.DiemDanhs.Add(dd);
                await db.SaveChangesAsync();
                return Ok(new { Code = 200 });
            }
            else
                return Ok(new { Code = 201 });

        }

        [AllowAnonymous]
        [Route("GetXinPhep")]
        [HttpGet]
        public async Task<IHttpActionResult> GetXinPhep(string MaUser)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var data = await db.DuKienTTs.ToArrayAsync();

            if (data.Where(x => x.MaUser == MaUser).Count() > 0)
            {
                List<dynamic> dat = new List<dynamic>();
                for (int i = 1; i < 10; i++)
                {
                    var k = data.Where(x => x.MaUser == MaUser && x.Tuan == i.ToString()).ToList();
                    var lv = new List<DiemDanhView>();
                    foreach (var item in k)
                    {
                        lv.Add(new DiemDanhView()
                        {
                            MaDuKien = item.MaDuKien,
                            MaUser = item.MaUser,
                            Tuan = item.Tuan,
                            Thu = item.Thu,
                            Ngay = item.Ngay,
                            Thang = item.Thang,
                            Buoi = item.Buoi,
                            Diem = GetBuoiByMaDK(item.MaDuKien),
                            Color = GetColor(GetBuoiByMaDK(item.MaDuKien))
                        });
                    }
                    var da = new
                    {
                        Tuan = i,
                        da = lv
                    };
                    dat.Add(da);
                }
                int tong = 0;
                int xin = 0;
                int tongbuoi = 0;
                foreach (var item in data.Where(x => x.MaUser == MaUser))
                {
                    tong += db.DiemDanhs.Where(x => x.MaDuKien == item.MaDuKien).Count();
                    xin += db.XinPheps.Where(x => x.MaDuKien == item.MaDuKien).Count();
                }

                tongbuoi = data.Where(x => x.MaUser == MaUser&&(x.Buoi=="sang"||x.Buoi=="chieu")).Count()+(data.Where(x => x.MaUser == MaUser && (x.Buoi == "cangay")).Count()*2);
                string TongDD = tong.ToString();
                string XinPhep = xin.ToString();
                string Tong = tongbuoi.ToString();
                return Ok(new { Code = 200, data = dat ,
                    TongDD = TongDD,
                    XinPhep = XinPhep,
                    Tong = Tong
                });
            }
            return Ok(new { Code = 201 });
        }

        public string GetBuoiByMaDK(string ma)
        {
            var re = db.DiemDanhs.Where(x => x.MaDuKien == ma);
            string kq = "Chưa ĐD";
            switch (re.Count())
            {
                case 0:
                    if (db.XinPheps.Where(x => x.MaDuKien == ma).Count() > 0)
                    {
                        kq = "Đã XP";
                    }
                    break;
                case 1:
                    if (re.FirstOrDefault(x => x.Buoi == "sa") != null)
                        kq = "Sáng";
                    else kq = "Chiều";
                    break;
                case 2:
                    kq = "Cả ngày";
                    break;
            }
            return kq;
        }

        public string GetColor(string ma)
        {
            string kq = "";
            switch (ma)
            {
                case "Chưa ĐD":
                    kq = "cred";
                    break;
                case "Sáng":
                    kq = "cgreed";
                    break;
                case "Cả ngày":
                    kq = "cgreed";
                    break;
                case "Chiều":
                    kq = "cgreed";
                    break;
                case "Đã XP":
                    kq = "cyellow";
                    break;
            }
            return kq;
        }


    }
}
