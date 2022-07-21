import SwiftUI

public struct RoundedCornersShape: Shape {
    let radius: CGFloat
    let corners: UIRectCorner

    public init(
        radius: CGFloat,
        corners: UIRectCorner
    ) {
        self.radius = radius
        self.corners = corners
    }

    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(
                width: radius,
                height: radius
            )
        )
        return Path(path.cgPath)
    }
}

#if DEBUG
    struct RoundedCornerView_Previews: PreviewProvider {
        static var previews: some View {
            RoundedCornersShape(
                radius: 12,
                corners: [.allCorners]
            )
            .padding()
            .previewLayout(.fixed(width: 300, height: 100))
        }
    }
#endif
