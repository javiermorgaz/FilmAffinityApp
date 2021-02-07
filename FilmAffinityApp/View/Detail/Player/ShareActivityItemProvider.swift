//
//  ShareActivityItemProvider.swift
//  FilmAffinityApp
//
//  Created by Jmorgaz on 7/2/21.
//

import UIKit

final class ShareActivityItemProvider: UIActivityItemProvider {
  
  let title: String
  let url: URL
  
  init(title: String, url: URL) {
    self.title = title
    self.url = url
    super.init(placeholderItem: url)
  }
  
  override var item: Any {
    return url
  }
  
  override func activityViewController(_ activityViewController: UIActivityViewController,
                                       subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
    return title
  }
  
}
