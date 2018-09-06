import { Component } from '@angular/core';
import { NavController, NavParams ,AlertController} from 'ionic-angular';
import { HomePage } from '../home/home';
import { HttpClient} from '@angular/common/http';
import { NghiphepPage } from '../nghiphep/nghiphep';
import { ThongbaonvPage } from '../thongbaonv/thongbaonv';
@Component({
  selector: 'page-user',
  templateUrl: 'user.html'
})
export class UserPage {
  data: any;
  tuan:string;
  dataDuKien: any;
  maDK:string;
  date = new Date().toISOString();
  constructor(private alertCtrl: AlertController, public navCtrl: NavController, private httpClient: HttpClient,public navParams: NavParams) {
    this.data = navParams.get('data');
    this.GetWeek("");
    }
    GetWeek(value: any){
      if(this.data.MaUser == null)
      {
      this.alertCtrl.create({
        title: "Thông báo",
        subTitle: 'Nhân viên không tồn tại.',
        buttons: [{
          text:"Đóng",
          handler: data =>{
            this.navCtrl.push(HomePage);
          }
        }]
      }).present();
      
    }
    else  {
      this.tuan  = value;
      var link = '/DuKienTT/GetDayByWeek?MaUser='+this.data.MaUser+'&week='+this.tuan+'&date='+this.date;
      this.httpClient.get('/api'+link)
          .subscribe(data => {
            let cont = JSON.stringify(data);
            let dat =JSON.parse(cont);
            if(dat.Code ==200){
              this.dataDuKien = dat.data;
              this.tuan = dat.tuan!="0"?dat.tuan: value;
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
    getName(val:any){
      if(val == "cangay")
      return "Cả ngày";
      if(val == "sang")
      return "Sáng";
      if(val == "chieu")
      return "Chiều";
    }
 DiemDanh() {
  this.alertCtrl.create({
    title: 'Điểm danh',
    message: 'Bạn có muốn điểm danh không?',
    buttons: [
      {
        text: 'Chấp nhận',
        handler: data => {
          var link = '/DiemDanh/CreateDiemDanh?MaUser='+this.data.MaUser;
      this.httpClient.post('/api'+link,'')
          .subscribe(data => {
            let cont = JSON.stringify(data);
            let dat =JSON.parse(cont);
            if(dat.Code ==200){
              this.GetWeek("");
            }
            else
            {
              this.alertCtrl.create({
                title: "Thông báo",
                subTitle: "Bạn đã điểm danh",
                buttons: ["Đóng"]
              }).present();
            }
          });
        }
      },
      {
        text: 'Hủy'
      }
    ]
  }).present();
  }
  Xinnghi(){
    this.navCtrl.push(NghiphepPage,{data:this.data});
  }
  ThongBaoNV()
  {
     this.navCtrl.push(ThongbaonvPage,{data:this.data});
  }
}