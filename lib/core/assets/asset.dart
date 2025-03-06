const pngDir = "assets/images";
const svgDir = "assets/icons";

///AppBar
final kcompanyLogo = 'companylogo'.png;
final kprofile = '81'.png;
final kframe = 'Frame_2608398'.png;
final kvol = 'vol'.png;

//icons
final kglobe = 'globe'.svg;
final ktools = 'Account+Tools'.svg;
final kBitcoin = 'bitcoin_icons'.svg;
final kdollar = 'dollar_icons'.svg;
final karrowup = 'arrow_up'.svg;
final karrowdown = 'arrow_down'.svg;
final kclock = 'clock'.svg;
final kcandle = 'Candle_Chart'.svg;
final kdiagonal = 'diagonal_arrow'.svg;
final kinfo = 'u_info-circle'.svg;

extension AssetExt on String {
  get goPng {
    return "assets/goicons/$this.png";
  }

  String get png {
    return "$pngDir/$this.png";
  }

  String get svg {
    return "$svgDir/$this.svg";
  }
}
