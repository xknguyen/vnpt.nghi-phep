import { Component } from '@angular/core';
import {FabContainer, NavController, NavParams ,AlertController} from 'ionic-angular';
import { HttpClient} from '@angular/common/http';
import { LichvadanhsachdiemdanhPage } from '../lichvadanhsachdiemdanh/lichvadanhsachdiemdanh';

@Component({
  selector: 'page-lichdangki',
  templateUrl: 'lichdangki.html',
})
export class LichdangkiPage {
  listDK:any;
  listXP:any;
  tongBuoi:string;
  diemdanh:string;
  tongphep:string;
data:any;
maEmployee:string;
  constructor(private alertCtrl: AlertController,public navCtrl: NavController, public navParams: NavParams,private httpClient: HttpClient) {
    this.data = navParams.get('data');
    this.maEmployee = navParams.get('maEmployee');
    this.loadData();
    

  }

  ionViewDidLoad() {
    
  }
  getBuoi(val:string)
  {
    if(val=="sang")
    return "Sáng"
    if(val=="chieu")
    return "Chiều"
    if(val=="cangay")
    return "Cả ngày"
  }
  loadData()
  {
if(this.maEmployee != null)
    {
        var link2 = '/DiemDanh/GetXinPhep?MaUser='+this.maEmployee;
      this.httpClient.get('/api'+link2)
        .subscribe(data => {
          let cont = JSON.stringify(data);
          let dat =JSON.parse(cont);
          if(dat.Code ==200){
            this.listXP = dat.data;
            this.tongBuoi = dat.Tong;
            this.diemdanh=dat.TongDD;
            this.tongphep=dat.XinPhep;
          }
          else
          {
            this.alertCtrl.create({
              title: "Thông báo",
              subTitle: "Chưa đăng kí lịch dự kiến.",
              buttons: ["Đóng"]
            }).present();
          }
        });
        var link = '/DuKienTT/GetDuKien?MaUser='+this.maEmployee;
      this.httpClient.get('/api'+link)
        .subscribe(data => {
          let cont = JSON.stringify(data);
          let dat =JSON.parse(cont);
          if(dat.Code ==200){
            this.listDK = dat.data;
          }
          else
          {
            this.alertCtrl.create({
              title: "Thông báo",
              subTitle: "Chưa đăng kí lịch dự kiến.",
              buttons: ["Đóng"]
            }).present();
          }
        });
    }
    else{
      this.alertCtrl.create({
        title: "Thông báo",
        subTitle: "Nhân viên không tồn tại",
        buttons: [
          {
            text:"Đóng",
            handler: data => {
              this.navCtrl.push(LichvadanhsachdiemdanhPage,{data:this.data});
            }
          }
        ]
      }).present();
    }
  }
  refresh(fab?: FabContainer): void {
  if (fab !== undefined) {
    fab.close();
  }
  this.loadData();
}

}
