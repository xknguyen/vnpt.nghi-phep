import { Component } from '@angular/core';
import { NavController, NavParams ,AlertController} from 'ionic-angular';
import { HttpClient} from '@angular/common/http';
@Component({
  selector: 'page-taothongbao',
  templateUrl: 'taothongbao.html',
})
export class TaothongbaoPage {
tieude:string;
NBD:string;
NKT:string;
NoiDung:string;
MaUS:string;
  constructor(private alertCtrl: AlertController, public navCtrl: NavController, private httpClient: HttpClient,public navParams: NavParams) {
   this.MaUS = navParams.get('MaUS');
}

Send()
{
	var link = '/ThongBao/CreateThongBao?TieuDe='+this.tieude+'&NoiDung='+this.NoiDung+'&NBD='+this.NBD+'&NKT='+this.NKT+'&US='+this.MaUS;
      this.httpClient.post('/api'+link,'')
          .subscribe(data => {
            let cont = JSON.stringify(data);
            let dat =JSON.parse(cont);
            if(dat.Code == 200){
              this.alertCtrl.create({
                title: "Thông báo",
                subTitle: "Tạo thông báo thành công.",
                buttons: [{
                  text:"Đóng",
                  handler: data => {
                  }
                }]
              }).present();
               
            }
          });
}
}
