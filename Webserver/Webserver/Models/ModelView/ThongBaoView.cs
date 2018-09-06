using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Webserver.Models.ModelView
{
    public class ThongBaoView
    {
        public string MaTB { get; set; }
        public string TieuDe { get; set; }
        public string NoiDung { get; set; }
        public string NgayBatDau { get; set; }
        public string NgayKetThuc { get; set; }
        public string MaUser { get; set; }
        public string NgayTao { get; set; }
    }
}