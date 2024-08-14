//
//  NetworkManager.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 19.06.24.
//

import Foundation
import Combine

enum Errors: String, Error {
    case invalidResponse = "The response from the server was invalid."
    case invalidData = "The data received from the server was invalid."
}

class NetworkManager: ObservableObject {
    @Published var users: [User] = []
    private var timer: AnyCancellable?
    
    init() {
        start()
        fetchUsers()
    }
    
    func start() {
        timer = Timer.publish(every: 3040409595, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.fetchUsers()
            }
    }
    
    func fetchUsers() {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/users")!) { data, _, error in
            guard let data = data else {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                return
            }
            do {
                let fetch = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    self.users = fetch
                }
            } catch {
                print("Decoding error: \(error.localizedDescription) эта ошибка получается в файле NetworkManager")
            }
        }.resume()
    }
}
