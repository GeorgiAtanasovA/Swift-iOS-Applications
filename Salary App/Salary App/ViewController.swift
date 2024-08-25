//
//  ViewController.swift
//  Salary App
//
//  Created by Georgi on 31.05.20.
//  Copyright © 2020 Georgi. All rights reserved.
//

import UIKit
import SafariServices
import WebKit
import Foundation

class ViewController: UIViewController,UITextFieldDelegate
{
	@IBOutlet var result: UITextField!
	@IBOutlet var skattTxt: UITextField!
	@IBOutlet var timmarTxt: UITextField!
	@IBOutlet var lönTimmeTxt: UITextField!
	@IBOutlet var webView: WKWebView!
	@IBOutlet var doneBtn: UIButton!
	@IBOutlet var transPaBtn: UIButton!
	@IBOutlet var iCalendarBtn: UIButton!
	@IBOutlet var iCalculateBtn: UIButton!
	@IBOutlet var currConverterBtn: UIButton!
	@IBOutlet var CalculateYourSalaryBtn: UIButton!
	@IBOutlet var errorMessageInfo: UILabel!
	
	override func viewDidLoad()
	{
		Thread.sleep(forTimeInterval: 2)
		super.viewDidLoad()

		BtnBorder(transPaBtn as Any)
		BtnBorder(iCalendarBtn as Any)
		BtnBorder(iCalculateBtn as Any)
		BtnBorder(currConverterBtn as Any)
		BtnBorder(doneBtn as Any)

		ShadowOn(transPaBtn as Any)
		ShadowOn(iCalendarBtn as Any)
		ShadowOn(iCalculateBtn as Any)
		ShadowOn(currConverterBtn as Any)
		ShadowOn(doneBtn as Any)

		//Скриване на клавиаурата при натискане отстрани
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.keyboardHide))
		view.addGestureRecognizer(tap)
	}

	@IBAction func iCalculateShadowOff(_ sender: Any)
	{
		ShadowOff(iCalculateBtn as Any)
	}
	@IBAction func TransPaShadowOff(_ sender: Any)
	{
		ShadowOff(transPaBtn as Any)
	}
	@IBAction func iCalendarShadowOff(_ sender: Any)
	{
		ShadowOff(iCalendarBtn as Any)
	}
	@IBAction func CurrConverterShadowOff(_ sender: Any)
	{
		ShadowOff(currConverterBtn as Any)
	}
	@IBAction func DoneBtnShadowOff(_ sender: Any)
	{
		ShadowOff(doneBtn as Any)
	}
	@IBAction func calculateBtn(_ sender: Any)
	{
		//При вдигане на пръста от екрана се задейства функцията
		ShadowOn(iCalculateBtn as Any)

		let lönPerTimme:Double? = Double(lönTimmeTxt.text!)
		let timmar:Double? = Double(timmarTxt.text!)
		let skatt:Double? = Double(skattTxt.text!)

		//Проверка за грешно въведени данни
		let checkForInt0: Bool = lönPerTimme != nil;
		let checkForInt1: Bool = timmar != nil;
		let checkForInt2: Bool = skatt != nil;
		if(checkForInt0 == false){ WrongData(); return;}
		if(checkForInt1 == false){ WrongData(); return;}
		if(checkForInt2 == false){ WrongData(); return;}

		var summ = (lönPerTimme ?? 0) / 100;
		summ = summ * (skatt ?? 0);
		summ = (lönPerTimme ?? 0) - summ;
		summ = summ * (timmar ?? 0);

		let numberOfPlaces = 2.0
		let multiplier = pow(10.0, numberOfPlaces)
		summ = round(summ * multiplier) / multiplier
		//summ = round(summ);
		result.text = "Du ska få: " + String(summ) + " sek";

		keyboardHide();  //Скриване на клавиаурата при натискане на "Calculate"
		infoTextFont();
	}
	@IBAction func OpenTransPa(_ sender: Any)
	{
		ShadowOn(transPaBtn as Any)
		let alertMessageSum = UIAlertController(title: "Open transPa?", message: nil, preferredStyle: .alert)

		alertMessageSum.addAction(UIAlertAction(title: "Går in",style: .default, handler:
																{ACTION in
			self.webView.load(URLRequest(url: URL(string: "https://mytranspa.com/TimereportDefault.aspx")!))
			self.doneBtn.isHidden = false;
			self.webView.isHidden = false;
			self.infoTextFont();
			self.errorMessageInfo.text = "              DB Schenker arbetstid info";
		}))
		alertMessageSum.addAction(UIAlertAction(title: "Nej",style: .default, handler: nil))

		self.present(alertMessageSum, animated: true, completion: nil)
	}
	@IBAction func WriteSalarySite(_ sender: Any)
	{
		//------------ За довършване ----------
		let allertMesgSaveSalarySite = UIAlertController(title: "Write site!", message: "Your salary site", preferredStyle: .alert)
		allertMesgSaveSalarySite.addAction(UIAlertAction(title: "Ok", style: .default, handler: {ACTION in }))
		self.present(allertMesgSaveSalarySite, animated: true, completion: nil)
		
		//MARK: ----- Да направя бутон с който да се записва работен сайт
		/*  let fileSalatyURL = "salariSiteURL.txt" //this is the file. we will write to and read from it

		 let text = "some text" //just a text

		 if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

		 let fileURL = dir.appendingPathComponent(fileSalatyURL)

		 //writing
		 do {
		 try text.write(to: fileURL, atomically: false, encoding: .utf8)
		 }
		 catch {/* error handling here */}

		 //reading
		 do {
		 let text2 = try String(contentsOf: fileURL, encoding: .utf8)
		 }
		 catch {/* error handling here */}
		 }*/
	}
	@IBAction func CalendarBtn(_ sender: Any)
	{
		ShadowOn(iCalendarBtn as Any)
		
		//Метод за отваряне на друго приложение
		//let calendarURL = URL(string: "calshow://");
		//UIApplication.shared.open(urlCalendar!);
		
		///оформяне на съобщение с два бутона
		let alertMessageSum = UIAlertController(title: "Open Calendar?", message: nil, preferredStyle: .alert)
		
		//оформяне на бутони
		alertMessageSum.addAction(UIAlertAction(title: "Ja",style: .default, handler: {ACTION in UIApplication.shared.open(URL(string: "calshow://")!)}))
		alertMessageSum.addAction(UIAlertAction(title: "Nej",style: .default, handler: nil))
		
		//показване на съобщение
		self.present(alertMessageSum, animated: true, completion: nil)
	}
	@IBAction func CurrConverter(_ sender: Any)
	{
		ShadowOn(currConverterBtn as Any)
		
		let alertMessageSum = UIAlertController(title: "Open Currency Converter?", message: nil, preferredStyle: .alert)
		alertMessageSum.addAction(UIAlertAction(title: "Ja",style: .default, handler:
																{ACTION in
			self.webView.load(URLRequest(url: URL(string: "https://www.mataf.net/bg/widget/conversiontab-SEK-BGN")!))
			self.doneBtn.isHidden = false;
			self.webView.isHidden = false;
			self.infoTextFont();
			self.errorMessageInfo.text = "              Currency Converter by Mataf";
		}))
		alertMessageSum.addAction(UIAlertAction(title: "Nej",style: .default, handler: nil))
		present(alertMessageSum, animated: true, completion: nil)
	}
	@IBAction func DoneBtn (_ sender: Any)
	{
		ShadowOn(doneBtn as Any)
		doneBtn.isHidden = true;
		webView.isHidden = true;
		errorMessageInfo.text = "Hej, scriv ditt lön per timme, din timmar och skatt:"
		errorMessageInfo.font =  errorMessageInfo.font.withSize(16)
	}
	@IBAction func infoBtn(_ sender: Any)
	{
		//Дефиниране на прозореца на съобщението
		let alertMessageSum = UIAlertController(title: "Info:", message: "Salary calculate: V1.2.5", preferredStyle: .alert)
		//оформяне на съобщение с бутон
		alertMessageSum.addAction(UIAlertAction(title: "OK",style: .cancel, handler: nil))
		//показване на съобщение
		self.present(alertMessageSum, animated: true, completion: nil)
	}
	//-------------------------------------
	@objc func keyboardHide()
	{
		//Скриване на клавиаурата при натискане отстрани
		view.endEditing(true)
	}
	func       WrongData()
	{
		//errorMessageInfo.backgroundColor = UIColor.red;
		errorMessageInfo.font =  errorMessageInfo.font.withSize(24);
		errorMessageInfo.textAlignment = NSTextAlignment.center;
		errorMessageInfo.text = "Error, write digits!!!";

		result.text = "NaN"
		keyboardHide()
	}
	func       infoTextFont()
	{
		errorMessageInfo.backgroundColor = UIColor.init(white: 0, alpha: 0);
		errorMessageInfo.font =  errorMessageInfo.font.withSize(16);
		errorMessageInfo.textAlignment = NSTextAlignment.left;
		errorMessageInfo.text = "Hej, scriv ditt lön per timme, din timmar och skatt:";
	}
	func       ShadowOn(_ forShadow: Any)
	{
		(forShadow as AnyObject).layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.70).cgColor;
		(forShadow as AnyObject).layer.shadowOffset = CGSize(width: 5.0, height: 5.0);
		(forShadow as AnyObject).layer.shadowOpacity = 3.0;
		(forShadow as AnyObject).layer.shadowRadius = 5.0;
	}
	func       ShadowOff(_ forShadow: Any)
	{
		(forShadow as AnyObject).layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.70).cgColor;
		(forShadow as AnyObject).layer.shadowOffset = CGSize(width: 1.0, height: 1.0);
		(forShadow as AnyObject).layer.shadowOpacity = 1.0;
		(forShadow as AnyObject).layer.shadowRadius = 2.0;
	}
	func       BtnBorder(_ forShadow: Any)
	{
		(forShadow as AnyObject).layer.cornerRadius = 5;
		(forShadow as AnyObject).layer.borderWidth = 1.2;
		(forShadow as AnyObject).layer.borderColor = UIColor.darkGray.cgColor;
	}
}
