import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams ,AlertController} from 'ionic-angular';
import { HomePage } from '../home/home';
import { HttpClient} from '@angular/common/http';
import { UserPage } from '../user/user';

@Component({
  selector: 'page-dangkilich',
  templateUrl: 'dangkilich.html',
})
export class DangkilichPage {
data: any;
tuan:string;
t2:string;
t3:string;
t4:string;
t5:string;
t6:string;
ngay:string;
thang:string;
  constructor(private alertCtrl: AlertController, public navCtrl: NavController, private httpClient: HttpClient,public navParams: NavParams) {
    this.data = navParams.get('data');
  }

  ionViewDidLoad() {
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
    else{
      this.checkValidation();
    }
    //console.log('ionViewDidLoad DangkilichPage');
  }
bttieptuc(){
  if(this.tuan!=null && this.t2 !=null && this.t3 !=null && this.t4!=null && this.t5 !=null && this.t6!=null )
  {
    this.ngay = this.ngay==null? '0':this.ngay;
    this.thang = this.thang==null? '0':this.thang;
    var link = '/DuKienTT/PostDuKienTT?MaTK='+this.data.MaUser+'&tuan='+this.tuan
    +'&t2='+this.t2 +'&t3='+this.t3 +'&t4='+this.t4 +'&t5='+this.t5 +'&t6='+this.t6 
    +'&ngay='+this.ngay +'&thang='+this.thang;
      this.httpClient.post('/api'+link,'')
          .subscribe(data => {
            let cont = JSON.stringify(data);
            let dat =JSON.parse(cont);
            if(dat.Code == 200){
              this.ngay = dat.ngay;
              this.thang = dat.thang;
              this.alertCtrl.create({
                title: "Thông báo",
                subTitle: "Tạo lịch dự kiến cho tuần "+this.tuan+" thành công.",
                buttons: [{
                  text:"Đóng",
                  handler: data => {
                    this.tuan  = (this.tuan <= '9') ? (parseInt(this.tuan) + 1).toString():'10';
                    this.t2 = '';
                    this.t3 = '';
                    this.t4 = '';
                    this.t5 = '';
                    this.t6 = '';
                    if(this.tuan == '10')
                    {
                      this.navCtrl.push(UserPage,{data:this.data});
                    }
                  }
                }]
              }).present();
               
            }
            else
            {
              this.alertCtrl.create({
                title: "Thông báo",
                subTitle: "Không thể thêm lịch dự kiện",
                buttons: ["Đóng"]
              }).present();
            }
              
          });
  }
  else
  {
    this.alertCtrl.create({
      title: "Thông báo",
      subTitle: "Bạn vui lòng chọn đầy đủ thông tin.",
      buttons: ["Đóng"]
    }).present();
  }
  
}
checkValidation()
{
      var link = '/DuKienTT/CheckDuKien?MaUser='+this.data.MaUser;
      this.httpClient.get('/api'+link)
          .subscribe(data => {
            let cont = JSON.stringify(data);
            let dat =JSON.parse(cont);
            if(dat.Code ==200){
              this.ngay = dat.ngay;
              this.thang = dat.thang;
              this.tuan  = dat.tuan;
              this.t2 = '';
              this.t3 = '';
              this.t4 = '';
              this.t5 = '';
              this.t6 = '';
            }
          });
}
}
