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
    [RoutePrefix("api/XinPhep")]
    public class XinPhepController : ApiController
    {
        AppEntities db = new AppEntities();
        [AllowAnonymous]
        [Route("CreateXinPhep")]
        [HttpPost]
        public async Task<IHttpActionResult> CreateXinPhep(string MaUser, string NgayPhep, string Buoi, string LyDo)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            DateTime date = new DateTime();
            string[] NgayPheps = NgayPhep.Trim().Split('-');
            date = DateTime.Parse(NgayPheps[1] + "/" + NgayPheps[0] + "/" + NgayPheps[2]);// ngày xin nghỉ
            if (date.Date >= DateTime.Now.Date)// nếu ngày xin nghỉ lớn hơn hoặc bằng ngày hiện tại thid=f mới thực hiện 
            {
                var dk = db.DuKienTTs.FirstOrDefault(x => x.Ngay == date.Day.ToString() && x.Thang == date.Month.ToString() && x.MaUser == MaUser);
                //
                string ma = "XP_" + dk.MaDuKien + "_" + Buoi.ToUpper();
                //
                if (Buoi.ToUpper() == "CN")
                {
                    if ((db.XinPheps.FirstOrDefault(x => x.MaXP == ma) == null)
                        && (db.XinPheps.FirstOrDefault(x => x.MaXP == "XP_" + dk.MaDuKien + "_SA") == null)
                        &&(db.XinPheps.FirstOrDefault(x => x.MaXP == "XP_" + dk.MaDuKien + "_CH") == null))//Chưa xin phép
                    {

                        XinPhep dd = new XinPhep();
                        dd.MaXP = ma;
                        dd.MaDuKien = dk.MaDuKien;
                        dd.NgayTao = DateTime.Now;
                        dd.Buoi = Buoi;
                        dd.LyDo = LyDo;
                        dd.DaXem = false;
                        db.XinPheps.Add(dd);
                        await db.SaveChangesAsync();
                        return Ok(new { Code = 200 });//Thành công
                    }
                    else
                        return Ok(new { Code = 201 });// Đã Xin phép
                }
                else if (db.XinPheps.FirstOrDefault(x => x.MaXP == ma) == null)//Chưa xin phép
                {

                    XinPhep dd = new XinPhep();
                    dd.MaXP = ma;
                    dd.MaDuKien = dk.MaDuKien;
                    dd.NgayTao = DateTime.Now;
                    dd.Buoi = Buoi;
                    dd.LyDo = LyDo;
                    dd.DaXem = false;
                    db.XinPheps.Add(dd);
                    await db.SaveChangesAsync();
                    return Ok(new { Code = 200 });//Thành công
                }
                else
                    return Ok(new { Code = 201 });// Đã Xin phép
            }
            else
                return Ok(new { Code = 202 });//Không thể xin phép cho quá khứ

        }

        [AllowAnonymous]
        [Route("GetXinPhep")]
        [HttpGet]
        public async Task<IHttpActionResult> GetXinPhep()
        {
            var da = await db.XinPheps.ToListAsync();
            List<XinPhepView> lst = new List<XinPhepView>();
            foreach (var item in da)
            {
                var madk = db.DuKienTTs.FirstOrDefault(x => x.MaDuKien == item.MaDuKien);
                var ht = db.TaiKhoans.FirstOrDefault(x => x.MaUser == madk.MaUser);
                string ngayxp = madk.Thang + "/" + madk.Ngay + "/"+ht.NienKhoa;
                lst.Add(new XinPhepView()
                {
                    MaXP = item.MaXP,
                    HoTen = ht.HoTen,
                    NgayXP = ngayxp,
                    DaXem = item.DaXem.ToString()
                });
            }
            return Ok(new { Code = 200, data = lst.OrderByDescending(x=>DateTime.Parse(x.NgayXP)).ToList() });//Không thể xin phép cho quá khứ

        }
        [AllowAnonymous]
        [Route("DoiTrangThai")]
        [HttpPost]
        public async Task<IHttpActionResult> DoiTrangThai(string MaXP)
        {
            XinPhep xp = db.XinPheps.FirstOrDefault(x => x.MaXP == MaXP);
            if (xp != null)
            {
                if (xp.DaXem == false)
                {
                    xp.DaXem = true;
                    await db.SaveChangesAsync();
                    return Ok(new { Code = 200 });
                }

            }
            return Ok(new { Code = 201 });//Không thể xin phép cho quá khứ

        }
        [AllowAnonymous]
        [Route("GetXinPhepByID")]
        [HttpPost]
        public async Task<IHttpActionResult> GetXinPhepByID(string MaXP)
        {
            var da = await db.XinPheps.ToListAsync();
            var dt = da.FirstOrDefault(x=>x.MaXP == MaXP);
            var dk = db.DuKienTTs.FirstOrDefault(x => x.MaDuKien == dt.MaDuKien);
            var us = db.TaiKhoans.FirstOrDefault(x => x.MaUser == dk.MaUser);
            var data = new {
                HoTen = us.HoTen,
                NgayXP = dk.Ngay + "/" + dk.Thang + "/" + us.NienKhoa,
                NgayTao = String.Format("{0:dd/MM/yyyy}", dt.NgayTao),
                TrangThai = dt.DaXem,
                Buoi = dt.Buoi,
                LyDo = dt.LyDo
            };
            return Ok(new { Code = 200, data = data});//Không thể xin phép cho quá khứ

        }

    }
}
