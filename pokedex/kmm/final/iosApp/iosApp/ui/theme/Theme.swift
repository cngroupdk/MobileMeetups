import SwiftUI

public struct Theme {
    public static let fonts = Font()
    public static let space = Space()
    public static let radii = Radii()
    public static let borderWidths = BorderWidths()
    public static let colors = Theme.Color()

    // MARK:  Font
    public struct Font {

        public func main(_ size: CGFloat, relativeTo: SwiftUI.Font.TextStyle) -> SwiftUI.Font {
            SwiftUI.Font.system(size: size)
        }
    }

    // MARK:  Space
    public struct Space {
        /// ```0```
        public let s0: CGFloat = 0
        /// ```4```
        public let s1: CGFloat = 4
        /// ```8```
        public let s2: CGFloat = 8
        /// ```12```
        public let s3: CGFloat = 12
        /// ```16```
        public let s4: CGFloat = 16
        /// ```24```
        public let s5: CGFloat = 24
        /// ```32```
        public let s6: CGFloat = 32
        /// ```40```
        public let s7: CGFloat = 40
        /// ```48```
        public let s8: CGFloat = 48
        /// ```64```
        public let s9: CGFloat = 64
        /// ```80```
        public let s10: CGFloat = 80
        /// ```96```
        public let s11: CGFloat = 96
        /// ```104```
        public let s12: CGFloat = 104
        /// ```120```
        public let s13: CGFloat = 120
        /// ```144```
        public let s14: CGFloat = 144
        /// ```176```
        public let s15: CGFloat = 176
        /// ```200```
        public let s16: CGFloat = 200
    }

    // MARK:  Radii
    public struct Radii {
        /// ```2```
        public let r1: CGFloat = 2
        /// ```4```
        public let r2: CGFloat = 4
        /// ```8```
        public let r3: CGFloat = 8
        /// ```16```
        public let r4: CGFloat = 16
        /// ```20```
        public let r5: CGFloat = 20
        /// ```36```
        public let r6: CGFloat = 36
    }

    // MARK: BorderWidths
    public struct BorderWidths {
        /// ```0```
        public let b0: CGFloat = 0
        /// ```1```
        public let b1: CGFloat = 1
        /// ```2```
        public let b2: CGFloat = 2
        /// ```3```
        public let b3: CGFloat = 3
        /// ```4```
        public let b4: CGFloat = 4
        /// ```10```
        public let b10: CGFloat = 10
    }
}
