import { Component } from '@angular/core';
import { NavController ,AlertController} from 'ionic-angular';
import { AdminPage } from '../admin/admin';
import { DangkilichPage } from '../dangkilich/dangkilich';
import { HttpClient} from '@angular/common/http';
import { UserPage } from '../user/user';
@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {
username:string;
password:string;
constructor(private alertCtrl: AlertController, public navCtrl: NavController, private httpClient: HttpClient) {
  }  
  GoLogin(){
    if(this.username != null && this.password != null){
      var link = '/TaiKhoan/login?userName='+this.username+'&password='+this.password;
    this.httpClient.post('/api'+link,'')
        .subscribe(data => {
          let cont = JSON.stringify(data);
          let dat =JSON.parse(cont);
          if(dat.Code ==200){
            this.alertCtrl.create({
              title: "Đăng nhập thành công",
              subTitle: "Xin chào "+dat.data.HoTen,
              buttons: [
                {
                  text:"Đóng",
                  handler: data => {
                    if(dat.data.MaQuyen == "Admin")
                    {
                      this.navCtrl.setRoot(AdminPage,{data:dat.data});
                    }
                    else
                    {
                      var link2 = '/DuKienTT/CountDuKienTT?MaTK='+dat.data.MaUser;
                      this.httpClient.post('/api'+link2,'')
                      .subscribe(data => {
                        let cont2 = JSON.stringify(data);
                        let dat2 =JSON.parse(cont2);
                        if(dat2.Code ==200){
                          if(dat2.Count == "45")
                          {
                            this.navCtrl.setRoot(UserPage,{data:dat.data});
                          }
                          else
                          {
                            this.navCtrl.setRoot(DangkilichPage,{data:dat.data});
                          }
                        }
                      }, error => {
                          console.log(JSON.stringify(error));
                      });
                    }
                  }
                }
              ]
            }).present();
            // 
          }
          else
          {
            this.alertCtrl.create({
              title: "Đăng nhập lỗi",
              subTitle: this.username +" không tồn tại.",
              buttons: ["Đóng"]
            }).present();
          }
        });
    }
    else
    {
      this.alertCtrl.create({
        title: "Thông báo",
        subTitle: "Bạn vui lòng nhập đầy đủ thông tin.",
        buttons: ["Đóng"]
      }).present();
    }
    
  }
}
