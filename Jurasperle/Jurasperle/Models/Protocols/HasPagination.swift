//
//  HasPagination.swift
//  Jurasperle
//
//  Created by Sherzod on 7/21/18.
//  Copyright © 2018 Humanz. All rights reserved.
//

import Foundation

protocol HasPagination
{
    var pageMetadata: PageMetadata? {
        get
        set
    }
}

extension HasPagination
{
    func goNextPage()
    {
        
    }
    
    func goPrevPage()
    {
        
    }
}
