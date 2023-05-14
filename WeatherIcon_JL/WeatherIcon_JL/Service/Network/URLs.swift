//  Created by jianli on 5/23/23.
//

import Foundation

enum URLs {
    case base
    case icon(name: String, size: Int)
    
    var string: String {
        switch self {
        case .base:
            return "https://api.openweathermap.org/data/2.5/weather?"
        case .icon(let name, let size):
            return "https://openweathermap.org/img/wn/\(name)@\(size)x.png"
        }
    }
}

