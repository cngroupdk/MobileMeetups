import SwiftUI

struct StatInfo: View {
  let label: String
  let value: Int?

  var body: some View {
    HStack {
      Text(label)
        .foregroundColor(.gray)

      Spacer()

      if value != nil {
        Text("\(value!)")
      }
    }
    .padding(.bottom)
    .padding(.horizontal, 30)
  }
}

#if DEBUG
  struct StatInfo_Previews: PreviewProvider {
    static var previews: some View {
      StatInfo(label: "HP", value: 55)
        .previewLayout(.sizeThatFits)
        .padding()
    }
  }
#endif
