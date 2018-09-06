import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams ,AlertController} from 'ionic-angular';
import{LichdangkiPage} from '../lichdangki/lichdangki';
import { HttpClient} from '@angular/common/http';
@Component({
  selector: 'page-lichvadanhsachdiemdanh',
  templateUrl: 'lichvadanhsachdiemdanh.html',
})
export class LichvadanhsachdiemdanhPage {
  data: any;
  employee: any;
  selectedItem: any;
  icons: string[];
  items: Array<{title: string, note: string, icon: string}>;

  constructor(private alertCtrl: AlertController,public navCtrl: NavController, public navParams: NavParams,private httpClient: HttpClient) {
    this.data = navParams.get('data');
    var link = '/TaiKhoan/getAllEmployee';
    this.httpClient.get('/api'+link)
        .subscribe(data => {
          let cont = JSON.stringify(data);
          let dat =JSON.parse(cont);
          if(dat.Code ==200){
            this.employee = dat.data;
          }
          else
          {
            this.alertCtrl.create({
              title: "Thông báo",
              subTitle: "Lấy danh sách chưa đăng kí",
              buttons: ["Đóng"]
            }).present();
          }
        });
  }
btdangkidiemdanh(val:string){
  this.navCtrl.push(LichdangkiPage,{data:this.data, maEmployee:val});
}
}

