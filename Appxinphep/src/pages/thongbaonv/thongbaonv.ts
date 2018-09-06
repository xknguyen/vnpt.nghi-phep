import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams ,AlertController} from 'ionic-angular';
import { ChitietthongbaonvPage } from '../chitietthongbaonv/chitietthongbaonv';
import { HttpClient} from '@angular/common/http';
@Component({
  selector: 'page-thongbaonv',
  templateUrl: 'thongbaonv.html',
})
export class ThongbaonvPage {
  data: any;
  dataR:any;
  icons: string[];

  constructor(private alertCtrl: AlertController, public navCtrl: NavController, private httpClient: HttpClient,public navParams: NavParams) {
  
    this.data = navParams.get('data');
    this.GetWeek();

    this.icons = ['flask', 'wifi', 'beer', 'football', 'basketball', 'paper-plane',
    'american-football', 'boat', 'bluetooth', 'build'];
  }
GetWeek(){
      var link = '/ThongBao/GetThongBao';
      this.httpClient.get('/api'+link)
          .subscribe(data => {
            let cont = JSON.stringify(data);
            let dat =JSON.parse(cont);
            if(dat.Code == 200){
              this.dataR = dat.data;
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
getIcon(){
  return this.icons[Math.floor(Math.random() * this.icons.length)];
}
   itemTapped(MaTB:string) {
    this.navCtrl.push(ChitietthongbaonvPage, { data:this.data,
      MaTB: MaTB
    });
  }
}
