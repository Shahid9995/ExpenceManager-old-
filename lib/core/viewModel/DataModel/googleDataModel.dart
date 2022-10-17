class GoogleDataModel {
  bool? status;
  String? message;
  List<Data>? data;

  GoogleDataModel({this.status, this.message, this.data});

  GoogleDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? kind;
  String? title;
  String? htmlTitle;
  String? link;
  String? displayLink;
  String? snippet;
  String? htmlSnippet;
  String? cacheId;
  String? formattedUrl;
  String? htmlFormattedUrl;
  Pagemap? pagemap;

  Data(
      {this.kind,
        this.title,
        this.htmlTitle,
        this.link,
        this.displayLink,
        this.snippet,
        this.htmlSnippet,
        this.cacheId,
        this.formattedUrl,
        this.htmlFormattedUrl,
        this.pagemap});

  Data.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    title = json['title'];
    htmlTitle = json['htmlTitle'];
    link = json['link'];
    displayLink = json['displayLink'];
    snippet = json['snippet'];
    htmlSnippet = json['htmlSnippet'];
    cacheId = json['cacheId'];
    formattedUrl = json['formattedUrl'];
    htmlFormattedUrl = json['htmlFormattedUrl'];
    pagemap =
    json['pagemap'] != null ? new Pagemap.fromJson(json['pagemap']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['title'] = this.title;
    data['htmlTitle'] = this.htmlTitle;
    data['link'] = this.link;
    data['displayLink'] = this.displayLink;
    data['snippet'] = this.snippet;
    data['htmlSnippet'] = this.htmlSnippet;
    data['cacheId'] = this.cacheId;
    data['formattedUrl'] = this.formattedUrl;
    data['htmlFormattedUrl'] = this.htmlFormattedUrl;
    if (this.pagemap != null) {
      data['pagemap'] = this.pagemap!.toJson();
    }
    return data;
  }
}

class Pagemap {
  List<CseThumbnail>? cseThumbnail;
  List<Metatags>? metatags;
  List<CseImage>? cseImage;

  Pagemap({this.cseThumbnail, this.metatags, this.cseImage});

  Pagemap.fromJson(Map<String, dynamic> json) {
    if (json['cse_thumbnail'] != null) {
      cseThumbnail = <CseThumbnail>[];
      json['cse_thumbnail'].forEach((v) {
        cseThumbnail!.add(new CseThumbnail.fromJson(v));
      });
    }
    if (json['metatags'] != null) {
      metatags = <Metatags>[];
      json['metatags'].forEach((v) {
        metatags!.add(new Metatags.fromJson(v));
      });
    }
    if (json['cse_image'] != null) {
      cseImage = <CseImage>[];
      json['cse_image'].forEach((v) {
        cseImage!.add(new CseImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cseThumbnail != null) {
      data['cse_thumbnail'] =
          this.cseThumbnail!.map((v) => v.toJson()).toList();
    }
    if (this.metatags != null) {
      data['metatags'] = this.metatags!.map((v) => v.toJson()).toList();
    }
    if (this.cseImage != null) {
      data['cse_image'] = this.cseImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CseThumbnail {
  String? src;
  String? width;
  String? height;

  CseThumbnail({this.src, this.width, this.height});

  CseThumbnail.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['src'] = this.src;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Metatags {
  String? ogImage;
  String? ogType;
  String? articlePublishedTime;
  String? twitterCard;
  String? twitterTitle;
  String? ogImageWidth;
  String? ogSiteName;
  String? ogTitle;
  String? ogImageHeight;
  String? twitterLabel1;
  String? ogUpdatedTime;
  String? ogDescription;
  String? twitterImage;
  String? twitterData1;
  String? facebookDomainVerification;
  String? fbAppId;
  String? articleModifiedTime;
  String? viewport;
  String? twitterDescription;
  String? ogLocale;
  String? ogUrl;
  String? referrer;
  String? themeColor;
  String? formatDetection;
  String? msapplicationTilecolor;
  String? twitterUrl;
  String? twitterAriaText;
  String? ogAriaText;
  String? twitterSite;
  String? ogImageSecureUrl;
  String? msapplicationTileimage;
  String? fbAdmins;
  String? pDomainVerify;

  Metatags(
      {this.ogImage,
        this.ogType,
        this.articlePublishedTime,
        this.twitterCard,
        this.twitterTitle,
        this.ogImageWidth,
        this.ogSiteName,
        this.ogTitle,
        this.ogImageHeight,
        this.twitterLabel1,
        this.ogUpdatedTime,
        this.ogDescription,
        this.twitterImage,
        this.twitterData1,
        this.facebookDomainVerification,
        this.fbAppId,
        this.articleModifiedTime,
        this.viewport,
        this.twitterDescription,
        this.ogLocale,
        this.ogUrl,
        this.referrer,
        this.themeColor,
        this.formatDetection,
        this.msapplicationTilecolor,
        this.twitterUrl,
        this.twitterAriaText,
        this.ogAriaText,
        this.twitterSite,
        this.ogImageSecureUrl,
        this.msapplicationTileimage,
        this.fbAdmins,
        this.pDomainVerify});

  Metatags.fromJson(Map<String, dynamic> json) {
    ogImage = json['og:image'];
    ogType = json['og:type'];
    articlePublishedTime = json['article:published_time'];
    twitterCard = json['twitter:card'];
    twitterTitle = json['twitter:title'];
    ogImageWidth = json['og:image:width'];
    ogSiteName = json['og:site_name'];
    ogTitle = json['og:title'];
    ogImageHeight = json['og:image:height'];
    twitterLabel1 = json['twitter:label1'];
    ogUpdatedTime = json['og:updated_time'];
    ogDescription = json['og:description'];
    twitterImage = json['twitter:image'];
    twitterData1 = json['twitter:data1'];
    facebookDomainVerification = json['facebook-domain-verification'];
    fbAppId = json['fb:app_id'];
    articleModifiedTime = json['article:modified_time'];
    viewport = json['viewport'];
    twitterDescription = json['twitter:description'];
    ogLocale = json['og:locale'];
    ogUrl = json['og:url'];
    referrer = json['referrer'];
    themeColor = json['theme-color'];
    formatDetection = json['format-detection'];
    msapplicationTilecolor = json['msapplication-tilecolor'];
    twitterUrl = json['twitter:url'];
    twitterAriaText = json['twitter:aria-text'];
    ogAriaText = json['og:aria-text'];
    twitterSite = json['twitter:site'];
    ogImageSecureUrl = json['og:image:secure_url'];
    msapplicationTileimage = json['msapplication-tileimage'];
    fbAdmins = json['fb:admins'];
    pDomainVerify = json['p:domain_verify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['og:image'] = this.ogImage;
    data['og:type'] = this.ogType;
    data['article:published_time'] = this.articlePublishedTime;
    data['twitter:card'] = this.twitterCard;
    data['twitter:title'] = this.twitterTitle;
    data['og:image:width'] = this.ogImageWidth;
    data['og:site_name'] = this.ogSiteName;
    data['og:title'] = this.ogTitle;
    data['og:image:height'] = this.ogImageHeight;
    data['twitter:label1'] = this.twitterLabel1;
    data['og:updated_time'] = this.ogUpdatedTime;
    data['og:description'] = this.ogDescription;
    data['twitter:image'] = this.twitterImage;
    data['twitter:data1'] = this.twitterData1;
    data['facebook-domain-verification'] = this.facebookDomainVerification;
    data['fb:app_id'] = this.fbAppId;
    data['article:modified_time'] = this.articleModifiedTime;
    data['viewport'] = this.viewport;
    data['twitter:description'] = this.twitterDescription;
    data['og:locale'] = this.ogLocale;
    data['og:url'] = this.ogUrl;
    data['referrer'] = this.referrer;
    data['theme-color'] = this.themeColor;
    data['format-detection'] = this.formatDetection;
    data['msapplication-tilecolor'] = this.msapplicationTilecolor;
    data['twitter:url'] = this.twitterUrl;
    data['twitter:aria-text'] = this.twitterAriaText;
    data['og:aria-text'] = this.ogAriaText;
    data['twitter:site'] = this.twitterSite;
    data['og:image:secure_url'] = this.ogImageSecureUrl;
    data['msapplication-tileimage'] = this.msapplicationTileimage;
    data['fb:admins'] = this.fbAdmins;
    data['p:domain_verify'] = this.pDomainVerify;
    return data;
  }
}

class CseImage {
  String? src;

  CseImage({this.src});

  CseImage.fromJson(Map<String, dynamic> json) {
    src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['src'] = this.src;
    return data;
  }
}
