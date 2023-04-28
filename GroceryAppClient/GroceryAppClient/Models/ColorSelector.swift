import SwiftUI

struct ColorSelectionView: View {
    
    let colors: [Color: String] = [.green: "#2ecc71", .red: "#e74c3c", .blue: "#3498db", .purple: "#9b59b6", .yellow: "#f1c40f"]
    @Binding var colorCode: String
    
    var body: some View {
        HStack {
            ForEach(colors.map { $0.key }, id: \.self) { color in
                Image(systemName: colorCode == colors[color] ?? "" ? "record.circle.fill" : "circle.fill")
                    .font(.title)
                    .foregroundColor(color)
                    .clipShape(Circle())
                    .onTapGesture {
                        colorCode = colors[color] ?? ""
                    }
            }
        }
    }
}

struct ColorSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelectionView(colorCode: .constant("#2ecc71"))
    }
}
