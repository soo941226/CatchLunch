//
//  CDModelManager.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/11.
//

import CoreData

final class CDModelManager<Model: NSManagedObject> {
    private let container: NSPersistentContainer
    private lazy var context = container.newBackgroundContext()

    init(about model: Model.Type, inDataModelFileName name: String = "CatchLunch") {
        container = NSPersistentContainer(name: name)
        container.loadPersistentStores { _, error in
            if let error = error {
                NotificationCenter.default.post(
                    name: .finishTaskWithError,
                    object: nil,
                    userInfo: ["message": error.localizedDescription]
                )
            }
        }
    }

    func count(with filter: NSPredicate? = nil) -> Int? {
        let request = Model.fetchRequest()
        if let filter = filter {
            request.predicate = filter
        }
        return try? context.count(for: request)
    }

    func retrieve(
        with filter: NSPredicate? = nil,
        completionHandler: @escaping (Result<[Model], Error>) -> Void
    ) {
        DispatchQueue.global().async { [weak self] in
            let request = Model.fetchRequest()

            if let filter = filter {
                request.predicate = filter
            }

            do {
                if let model = try self?.context.fetch(request) as? [Model] {
                    completionHandler(.success(model))
                }
            } catch {
                completionHandler(.failure(error))
            }
        }
    }

    func insert(
        setter: @escaping (NSManagedObject) -> Void,
        completionHandler: @escaping (Error?) -> Void
    ) {
        DispatchQueue.global().async { [weak self] in
            let model = NSManagedObject(entity: Model.entity(), insertInto: self?.context)
            setter(model)

            completionHandler(self?.tryToSaveContext())
        }
    }

    func inserts(
        amount: Int,
        setter: @escaping ([NSManagedObject]) -> Void,
        completionHandler: @escaping (Error?) -> Void
    ) {
        DispatchQueue.global().async { [weak self] in
            var models = [NSManagedObject]()
            for _ in 0..<amount {
                models.append(NSManagedObject(entity: Model.entity(), insertInto: self?.context))
            }
            setter(models)
            completionHandler(self?.tryToSaveContext())
        }
    }

    func update(
        with filter: NSPredicate? = nil,
        setter: @escaping ([Model]) -> Void,
        completionHandler: @escaping (Error?) -> Void
    ) {
        DispatchQueue.global().async { [weak self] in
            let request = Model.fetchRequest()

            if let filter = filter {
                request.predicate = filter
            }

            do {
                if let models = try self?.context.fetch(request) as? [Model] {
                    setter(models)
                }
            } catch {
                completionHandler(error)
            }
            completionHandler(self?.tryToSaveContext())
        }
    }

    func deleteAll(
        with filter: NSPredicate? = nil,
        completionHandler: @escaping (Error?) -> Void
    ) {
        retrieve(with: filter) { [weak self] result in
            switch result {
            case .success(let models):
                models.forEach { model in
                    self?.context.delete(model)
                }
                completionHandler(self?.tryToSaveContext())
            case .failure(let error):
                completionHandler(error)
            }
        }
    }

    @objc private func tryToSaveContext() -> Error? {
        if context.hasChanges {
            do {
                try context.save()
                return nil
            } catch {
                return error
            }
        }
        return nil
    }
}
