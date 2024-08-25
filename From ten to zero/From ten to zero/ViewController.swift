//
//  ViewController.swift
//  From ten to zero
//
//  Created by Georgi on 3.09.22.
//

import UIKit

class ViewController: UIViewController {


   var index = 1
   var countingSeconds = 0   //------- TEST -------
   var buttonTitleText = ""  //------- TEST -------
   var unedOrOverTen:Bool = true
   let timeInterval = 0.111
   var startStopTimer = false
   var timer_ShowText = Timer()

   let numberOne:[String] = ["    *",
                             "  * *",
                             "*   *",
                             "    *",
                             "    *",
                             "    *",
                             "    *",
                             "  *****"]
      //-------------------------------------------------------------

   @IBOutlet weak var textView: UITextView!
   @IBOutlet weak var PlayStop_btn: UIButton!
      //-------------------------------------------------------------


   override func viewDidLoad()
   {
		Thread.sleep(forTimeInterval: 2)

		super.viewDidLoad()


      let startText = "Let's start!"//.components(separatedBy: " ")
      textView.text = startText
   }

   @IBAction func HideKeyboard(_ sender: Any)
   {
      view.endEditing(true)  //Скриване на клавиаурата при натискане отстрани
   }
   @IBAction func Play_btn(_ sender: Any)
   {
      if(textView.text == "Let's start!"){textView.text = ""}

      if(startStopTimer == false)
      {
         startStopTimer = true
         PlayStop_btn.setTitle("S t o p", for: .normal)
         buttonTitleText = "S t o p"//------- TEST -------
         //Draw_TheNumbers()
         Draw_Picture()
      }
      else
      {
         startStopTimer = false
         PlayStop_btn.setTitle("P l a y", for: .normal)
         buttonTitleText = "P l a y"//------- TEST -------
         return
      }
   }
      //-------------------------------------------------------------

      //-------------------------------------------------------------
   @objc func Draw_TheNumbers()
   {
      if(startStopTimer == false) {
			return }

      if(index > numberOne.count - 1)
      {
         index = 0
         textView.text = ""
         timer_ShowText = Timer.scheduledTimer(timeInterval: 0.111, target: self, selector: #selector(Draw_TheNumbers), userInfo: nil, repeats: false)

         countingSeconds += 1 //------- TEST -------
         PlayStop_btn.setTitle(buttonTitleText + "   \(countingSeconds)", for: .normal)//------- TEST -------
      }
      else {
         textView.text += "\(numberOne[index])\n"
         index += 1
         timer_ShowText = Timer.scheduledTimer(timeInterval: 0.111, target: self, selector: #selector(Draw_TheNumbers), userInfo: nil, repeats: false)
      }
   }
   @objc func Draw_Picture()
   {
      if(startStopTimer == false){return}

      if(index <= 9 && unedOrOverTen == true) {
         for _ in 1...index {
				textView.text += "\(index) "
         }
         textView.text += "\n"
         index += 1
         timer_ShowText = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(Draw_Picture), userInfo: nil, repeats: false)
      }
      else if(index > 1 && unedOrOverTen == false) {
         index -= 1
         for _ in 1...index {
				textView.text += "\(index) "
         }
         textView.text += "\n"
         timer_ShowText = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(Draw_Picture), userInfo: nil, repeats: false)
      }
      else if(unedOrOverTen == true) {
         index -= 1
         timer_ShowText = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(Draw_Picture), userInfo: nil, repeats: false)
         unedOrOverTen = false
      }
      else {
         index = 1
         textView.text = ""
         timer_ShowText = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(Draw_Picture), userInfo: nil, repeats: false)
         unedOrOverTen = true
      }
   }
}
