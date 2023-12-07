/*--------------------------------------------------------------------------------------------------------------------------
    File: MessagesUI.swift
  Author: Kevin Messina
 Created: 07/16/23
Modified:
 
©2023 Creative App Solutions, LLC. - All Rights Reserved.
----------------------------------------------------------------------------------------------------------------------------
NOTES:
--------------------------------------------------------------------------------------------------------------------------*/

import MessageUI
import SwiftUI

func canSendText() -> Bool {
    return MFMessageComposeViewController.canSendText()
}

protocol MessagesViewDelegate {
    func messageCompletion(result: MessageComposeResult)
}

class MessagesViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    var delegate: MessagesViewDelegate?
    var recipients: [String]?
    var subject: String?
    var body: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayMessageInterface() {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        composeVC.recipients = self.recipients ?? []
        composeVC.subject = self.subject ?? ""
        composeVC.body = body ?? ""
        
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            self.delegate?.messageCompletion(result: MessageComposeResult.failed)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true)
        self.delegate?.messageCompletion(result: result)
    }
}

struct MessageUIView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var recipients: [String]
    @Binding var subject: String
    @Binding var body: String
    var completion: ((_ result: MessageComposeResult) -> Void)
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> MessagesViewController {
        let controller = MessagesViewController()
        controller.delegate = context.coordinator
        controller.recipients = recipients
        controller.subject = subject
        controller.body = body
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MessagesViewController, context: Context) {
        uiViewController.recipients = recipients
        uiViewController.subject = subject
        uiViewController.displayMessageInterface()
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, MessagesViewDelegate {
        var parent: MessageUIView
        
        init(_ controller: MessageUIView) {
            self.parent = controller
        }
        
        func messageCompletion(result: MessageComposeResult) {
            self.parent.presentationMode.wrappedValue.dismiss()
            self.parent.completion(result)
        }
    }
}


