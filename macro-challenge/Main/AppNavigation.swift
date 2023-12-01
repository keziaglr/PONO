//
//  AppNavigation.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 14/11/23.
//

import SwiftUI

enum Route {
    case onboarding
    case home
    case learningActivity
    case report
}

struct SwitchableNavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: (Route) -> Void = {_ in }
}

extension EnvironmentValues {
    var switchableNavigate: (Route) -> Void {
        get { self[SwitchableNavigationEnvironmentKey.self] }
        set { self[SwitchableNavigationEnvironmentKey.self] = newValue }
    }
}
