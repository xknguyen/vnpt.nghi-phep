import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams ,AlertController} from 'ionic-angular';
import { HttpClient} from '@angular/common/http';

@Component({
  selector: 'page-chitietnghiphep',
  templateUrl: 'chitietnghiphep.html',
})
export class ChitietnghiphepPage {

data: any;
maXP: string;
HoTen: string;
NgayXP: string;
NgayTao: string;
TrangThai: string;
Buoi: string;
LyDo: string;
constructor(private alertCtrl: AlertController, public navCtrl: NavController, private httpClient: HttpClient,public navParams: NavParams) {
    this.data = navParams.get('data');
this.maXP = navParams.get('maXP');
var link2 = '/XinPhep/GetXinPhepByID?MaXP='+this.maXP;
  this.httpClient.post('/api'+link2,'')
          .subscribe(data => {
            let cont = JSON.stringify(data);
            let dat =JSON.parse(cont);
            if(dat.Code ==200){
              	this.HoTen= dat.data.HoTen;
				this.NgayXP= dat.data.NgayXP;
				this.NgayTao= dat.data.NgayTao;
				this.TrangThai= dat.data.TrangThai?"Đã xem":"Chưa xem";
				this.Buoi= dat.data.Buoi;
				this.LyDo= dat.data.LyDo;
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
  ionViewDidLoad() {
    console.log('ionViewDidLoad ChitietnghiphepPage');
  }
  getBuoi(val:string){
if(val == "sa")
	return "Sáng";
if(val == "ch")
	return "Chiều";
if(val == "cn")
	return "Cả ngày";
  }

}
