//
//  FeedTableViewController.swift
//  RSS2
//
//  Created by A.S.Sahasranamam on 2/21/18.
//  Copyright © 2018 A.S.Sahasranamam. All rights reserved.
//

import UIKit
import AVKit
import CoreMedia

//TableViewController

class FeedTableViewController: UITableViewController {
   
    var stdURL: String = "http://tlc4u.org/feeds/sermons" //RSS URL
    
    @IBOutlet weak var NowPlaying: UINavigationItem!
    
    @IBAction func ViewCurrent(_ sender: Any) {
        if AppDelegate.RSSItemsx2 == nil{
            print("hello")
            return
        } else {
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil) //MainStoryboard
        //PlayerStoryboard
        
            let feedDetailsViewController: FeedDetailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "FeedDetailsViewController") as! FeedDetailsViewController
        
            feedDetailsViewController.rssItemsValue = AppDelegate.RSSItemsx2
        
            self.navigationController?.pushViewController(feedDetailsViewController, animated: true)
           
    }
    
    }
// Previous Code, Might be useful depending.
//     @IBOutlet weak var Lisle: UIBarButtonItem!
//    @IBAction func podcast1(_ sender: Any) {
//        stdURL = "http://tlc4u.org/feeds/sermons"
//        fetchData()
//    }
//    //@IBOutlet weak var GreenTrails: UIBarButtonItem!
//    @IBAction func podcast2(_ sender: Any) {
//        stdURL = "http://www.tlc4u.org/feeds/podcast/6"
//        fetchData()
//    }
//
//    //@IBOutlet weak var KimberlyWay: UIBarButtonItem!
//    @IBAction func podcast3(_ sender: Any) {
//        stdURL = "http://www.tlc4u.org/feeds/podcast/4"
//        fetchData()
//
//    }
//   // @IBOutlet weak var SNaperville: UIBarButtonItem!
//
//    @IBAction func podcast4(_ sender: Any) {
//        stdURL = "http://www.tlc4u.org/feeds/podcast/7"
//        fetchData()
//
//    }
//    @IBAction func stop(_ sender: Any) {
//    }
    
    
    private var rssItems: [RSSItem]? //RSSInformationArray
    
    //Refresh
    override func viewDidLoad() { //once view Loads
        super.viewDidLoad()

        fetchData() //GetData
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.estimatedRowHeight = 44
        
        self.tableView.register(UINib.init(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCellIdentifier") //FileForCellTemplate
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
   
    }
    private func fetchData(){
        let feedParser = FeedParser()
        feedParser.parseFeed(url: self.stdURL){ (rssItems) in
            self.rssItems=rssItems
         //   print(rssItems)
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer:0), with: .left)
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    // returns No of Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //Returns No of Rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let rssItems = rssItems else {
            return 0
        }
      // .. print(rssItems.count)
        return rssItems.count
    }

    
    //TRansfer of Data from RssItem Array to Cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCellIdentifier", for: indexPath) as! FeedTableViewCell
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedTableViewCell
        if let item = rssItems?[indexPath.item]{
            cell.item = item
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! FeedTableViewCell
        
        print(cell.item)
//        tableView.beginUpdates()
//        cell.descriptionLabel.numberOfLines = (cell.descriptionLabel.numberOfLines == 0) ? 3 : 0
//        cell.titleLabel.numberOfLines = (cell.titleLabel.numberOfLines == 0) ? 3 : 0
//        tableView.endUpdates()
        
        AppDelegate.stopPodCast()
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil) //MainStoryboard
        //PlayerStoryboard
        
        let feedDetailsViewController: FeedDetailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "FeedDetailsViewController") as! FeedDetailsViewController
        
        feedDetailsViewController.rssItemsValue = cell.item
        
        self.navigationController?.pushViewController(feedDetailsViewController, animated: true);
        
    }

    
    //AutoGenCOde
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
