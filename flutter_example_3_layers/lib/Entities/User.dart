class User{
  String id='';
  String name='';
  String email='';
  String password='';

  //User({required this.id,required this.name,required this.email,required this.token});
  Map<String,dynamic> toMap(){
    return {'id': this.id , 'name': this.name, 'email': this.email, 'password': this.password};
  }
}