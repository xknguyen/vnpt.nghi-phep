using Newtonsoft.Json;
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
    [RoutePrefix("api/DuKienTT")]
    public class DuKienTTController : ApiController
    {
        AppEntities db = new AppEntities();
        [AllowAnonymous]
        [Route("PostDuKienTT")]
        [HttpPost]
        public async Task<IHttpActionResult> PostDuKienTT(string MaTK, string tuan, string t2, string t3, string t4, string t5, string t6, string ngay, string thang)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            DuKienTT tt = new DuKienTT();
            TaiKhoan tk = db.TaiKhoans.FirstOrDefault(x => x.MaUser == MaTK);
            tt.MaUser = tk.MaUser;
            tt.Tuan = tuan;
            tt.Thu = t2;
            tt.Buoi = t2;
            string[] buoi = { t2, t3, t4, t5, t6 };
            int nga = ngay == "0" ? int.Parse(tk.BatDau.Value.Day.ToString()) : int.Parse(ngay);
            int thag = thang == "0" ? int.Parse(tk.BatDau.Value.Month.ToString()) : int.Parse(thang);
            string n1 = (ngay == "0") ? tk.BatDau.Value.Day.ToString() : nga.ToString();
            string n2 = (ngay == "0") ? (int.Parse(tk.BatDau.Value.Day.ToString()) + 1).ToString() : (nga + 1).ToString();
            string n3 = (ngay == "0") ? (int.Parse(tk.BatDau.Value.Day.ToString()) + 2).ToString() : (nga + 2).ToString();
            string n4 = (ngay == "0") ? (int.Parse(tk.BatDau.Value.Day.ToString()) + 3).ToString() : (nga + 3).ToString();
            string n5 = (ngay == "0") ? (int.Parse(tk.BatDau.Value.Day.ToString()) + 4).ToString() : (nga + 4).ToString();

            int days = DateTime.DaysInMonth(int.Parse(tk.NienKhoa), thag);
            if (int.Parse(n1) > days)
            {
                n1 = "1";
                n2 = "2";
                n3 = "3";
                n4 = "4";
                n5 = "5";
                nga = 8;
                thag++;
            }
            else if (int.Parse(n2) > days)
            {
                n2 = "1";
                n3 = "2";
                n4 = "3";
                n5 = "4";
                nga = 7;
            }
            else if (int.Parse(n3) > days)
            {
                n3 = "1";
                n4 = "2";
                n5 = "3";
                nga = 6;
            }
            else if (int.Parse(n4) > days)
            {
                n4 = "1";
                n5 = "2";
                nga = 5;
            }
            else if (int.Parse(n5) > days)
            {
                n5 = "1";//thứ 6/1 7/2 cn/3 thu2 4
                nga = 4;
            }
            else
            {
                nga = nga + 7;
            }


            string[] ngays = { n1, n2, n3, n4, n5 };
            var tha = thag;
            for (int i = 2; i <= 6; i++)
            {
                int ddd = int.Parse(ngays[i - 2]);

                
                string ma = tk.MaUser + "_" + i.ToString() + "_" + ngays[i - 2] + tha.ToString();
                var dt = db.DuKienTTs.FirstOrDefault(x => x.MaDuKien == ma);
                if (dt == null)
                {
                    db.DuKienTTs.Add(new DuKienTT()
                    {
                        MaDuKien = ma,
                        MaUser = MaTK,
                        Tuan = tuan,
                        Thu = i.ToString(),
                        Ngay = ngays[i - 2],
                        Thang = thag == 0 ? tk.BatDau.Value.Month.ToString() : tha.ToString(),
                        Buoi = buoi[i - 2]
                    });
                }
                else
                {
                    dt.Buoi = buoi[i - 2];
                    db.Entry(dt).State = EntityState.Unchanged;
                }
                tha = ddd == days ? (tha + 1) : tha;
            }
            await db.SaveChangesAsync();
            int nt = nga;
            return Ok(new { Code = 200, ngay = nt, thang = tha });
        }

        [AllowAnonymous]
        [Route("GetDayByWeek")]
        [HttpGet]
        public async Task<IHttpActionResult> GetDayByWeek(string MaUser, string week, string date)
        {
            DateTime time = new DateTime();
            var data = await db.DuKienTTs.ToListAsync();

            if (date != "")
            {
                time = DateTime.Parse(date);
            }

            var d = week != null ? data.Where(x => x.MaUser == MaUser && x.Tuan == week).ToList() :
                data.Where(x => x.MaUser == MaUser && x.Tuan == data.SingleOrDefault(y => y.MaUser == MaUser && y.Thang == time.Month.ToString() && y.Ngay == time.Day.ToString()).Tuan).ToList();
            string tuan = "0";
            if (week == null)
            {
                tuan = data.SingleOrDefault(y => y.MaUser == MaUser && y.Thang == time.Month.ToString() && y.Ngay == time.Day.ToString()).Tuan;
            }

            var lv = new List<DiemDanhView>();
            foreach (var item in d)
            {
                string ai = item.Thang + "/" + item.Ngay + "/" + DateTime.Now.Year;
                string di = DateTime.Now.ToShortDateString();
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
                    Color = di == ai ? "red" : ""
                });
            }
            return Ok(new { Code = 200, data = lv, tuan = tuan });

        }

        [AllowAnonymous]
        [Route("CountDuKienTT")]
        [HttpPost]
        public IHttpActionResult CountDuKienTT(string MaTK)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var re = db.DuKienTTs.Where(x => x.MaUser == MaTK).Count();
            return Ok(new { Code = 200, Count = re });
        }

        public IHttpActionResult getDayOfWeek(string MaUser)
        {
            var user = db.TaiKhoans.FirstOrDefault(x => x.MaUser == MaUser);
            DateTime start = (DateTime)user.BatDau;
            int s = DateTime.DaysInMonth(start.Year, start.Month);
            return Ok();
        }

        [AllowAnonymous]
        [Route("getDayByWeek")]
        [HttpPost]
        public IHttpActionResult getDayByWeek(string MaUser, string week)
        {
            var day = db.DuKienTTs.Where(x => x.MaUser == MaUser && x.Tuan == week);
            return Ok(new { Code = 200, data = day });
        }

        public string GetBuoiByMaDK(string ma)
        {
            var re = db.DiemDanhs.Where(x => x.MaDuKien == ma);
            string kq = "Chưa Điểm danh";
            switch (re.Count())
            {
                case 0:
                    if (db.XinPheps.Where(x => x.MaDuKien == ma).Count() > 0)
                    {
                        kq = "Đã xin phép";
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

        [AllowAnonymous]
        [Route("GetDuKien")]
        [HttpGet]
        public async Task<IHttpActionResult> GetDuKien(string MaUser)
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
                    var da = new
                    {
                        Tuan = i,
                        da = k
                    };
                    dat.Add(da);
                }
                return Ok(new { Code = 200, data = dat });
            }
            return Ok(new { Code = 201 });
        }

        [AllowAnonymous]
        [Route("CheckDuKien")]
        [HttpGet]
        public async Task<IHttpActionResult> CheckDuKien(string MaUser)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var data = await db.DuKienTTs.ToArrayAsync();
            var dt = data.Where(x => x.MaUser == MaUser).ToList();
            if (dt.Count() > 0)
            {
                int i = 1;
                string ngay = "";
                string thang = "";
                string tuan = "";
                while (i < 10)
                {
                    if (dt.Where(x => x.Tuan == i.ToString()).Count() < 5)
                    {
                        var t = dt.FirstOrDefault(x => x.Tuan == (i-1).ToString() && x.Thu == 2.ToString());
                        ngay = (int.Parse(t.Ngay)+7).ToString();
                        thang = t.Thang;
                        tuan = i.ToString();
                        i = 10;
                        return Ok(new { Code = 200, tuan = tuan, ngay = ngay, thang = thang });
                    }
                    else
                    {
                        i++;
                    }
                }
                return Ok(new { Code = 202});



            }
            return Ok(new { Code = 201 });
        }
    }
}
