
class SinglePartner{
  static String?  uid;
  static String?  uidPartner;
}


class PartnerList{
  final String uidPartner;
  final String uid;
  PartnerList(this.uidPartner, this.uid);
}

class PartnerListData{
  final String name;
  final String photoUrl;
  final String phoneNumber;
  final String preferences;

  PartnerListData(this.name, this.photoUrl, this.phoneNumber, this.preferences);

}
