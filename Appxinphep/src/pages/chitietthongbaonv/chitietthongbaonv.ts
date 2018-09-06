import { Component } from '@angular/core';
import { NavController, NavParams ,AlertController} from 'ionic-angular';
import { HttpClient} from '@angular/common/http';

@Component({
  selector: 'page-chitietthongbaonv',
  templateUrl: 'chitietthongbaonv.html',
})
export class ChitietthongbaonvPage {
MaTB:string;
data:any;
td:string;
bd:string;
kt:string;
nd:string;
  constructor(private alertCtrl: AlertController, public navCtrl: NavController, private httpClient: HttpClient,public navParams: NavParams) {
  this.data = navParams.get('data');
  this.MaTB = navParams.get('MaTB');
this.GetByID();
  }
GetByID()
{
	var link = '/ThongBao/GetThongBaoByID?MaTB='+this.MaTB;
      this.httpClient.get('/api'+link)
          .subscribe(data => {
            let cont = JSON.stringify(data);
            let dat =JSON.parse(cont);
            if(dat.Code == 200){
              this.td = dat.data.TieuDe;
              this.bd = dat.data.NgayBatDau;
              this.kt = dat.data.NgayKetThuc;
              this.nd = dat.data.NoiDung;
            }
            else
            {
              this.alertCtrl.create({
                title: "Thông báo",
                subTitle: "Lấy danh sách lỗi.",
                buttons: ["Đóng"]
              }).present();
            }
          });
}

}
